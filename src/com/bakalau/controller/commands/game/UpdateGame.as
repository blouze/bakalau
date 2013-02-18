/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 12/02/13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class UpdateGame
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameVO :GameVO = GameVO(event.data);
			trace("[GameDataReceived] update game: " + gameVO.gameID);

			var game :GameVO = gamesModel.getGameByID(gameVO.gameID);
			game.players = gameVO.players;
			gamesModel.bindings.invalidate(gamesModel, "games");

			if (game == gamesModel.selectedGame) {
				gamesModel.bindings.invalidate(gamesModel, "selectedGame");
			}
		}
	}
}
