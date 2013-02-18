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
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class GameDataReceived
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
			var gameVO :GameVO = GameVO(event.data);
			var game :GameVO = gamesModel.getGameByID(gameVO.gameID);

			if (!game) {
				trace("[GameDataReceived] new game: " + gameVO.gameID);

				gamesModel.addGame(gameVO);

				// select & join if current player created this game
				if (gameVO.gameID == playersModel.currentPlayerName) {
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.SELECT_GAME, gameVO.gameID));
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.JOIN_SELECTED_GAME));
				}
			}
			else {
				trace("[GameDataReceived] update game: " + game.gameID);

				game.players = gameVO.players;
				gamesModel.bindings.invalidate(gamesModel, "games");
				if (game == gamesModel.selectedGame) {
					gamesModel.bindings.invalidate(gamesModel, "selectedGame");
				}
			}
		}
	}
}
