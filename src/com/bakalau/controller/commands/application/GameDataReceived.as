/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 11:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.application
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.LocalNetworkModel;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class GameDataReceived
	{
		[Inject(source="localNetworkModel")]
		public var localNetworkModel :LocalNetworkModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var game :GameVO = GameVO(event.data);

			var existingGame :GameVO = gamesModel.getGameByID(game.gameID);

			if (!existingGame) {
				gamesModel.addNewGame(game);

				if (game.owner == localNetworkModel.channel.localClient) {
					gamesModel.localGame = game;
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.SELECT_GAME, game));
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.JOIN_SELECTED_GAME));
				}
			}
			else {

				if (existingGame.players.length != game.players.length) {
					existingGame.players = game.players;
					gamesModel.bindings.invalidate(gamesModel, "games");
				}

				if (game == gamesModel.selectedGame) {
					gamesModel.bindings.invalidate(gamesModel, "selectedGame");
				}
			}
		}
	}
}
