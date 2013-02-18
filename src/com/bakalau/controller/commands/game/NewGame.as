/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 12/02/13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class NewGame
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
			gamesModel.addGame(gameVO);

			trace("[GameDataReceived] new game: " + gameVO.gameID);

			// select & join if current player created this game
			if (gameVO.gameID == playersModel.currentPlayerName) {
				gameVO.gameOwner = playersModel.currentPlayerName;
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.SELECT_GAME, gameVO.gameID));
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.JOIN_SELECTED_GAME));
			}
		}
	}
}
