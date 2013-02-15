/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 15/02/13
 * Time: 12:00
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;

	import starling.events.EventDispatcher;



	public class GameJoined
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var joinedGameID :String = String(event.data);

			// if current player just created his own game
			if (joinedGameID == playersModel.currentPlayerName) {

				// select game
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.SELECT_GAME, joinedGameID));
				// update current game reference (players)
				gamesModel.currentGame = gamesModel.selectedGame;

				// add player to his own game
				if (gamesModel.selectedGame.players.lastIndexOf(playersModel.currentPlayerName) == -1) {
					gamesModel.addPlayerToCurrentGame(playersModel.currentPlayerName);
				}

				// tell everyone about this game
				playersModel.channel.sendMessageToAll(gamesModel.currentGame);
			}
			else {
				gamesModel.currentGame = gamesModel.selectedGame;
			}
		}
	}
}
