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
	import com.bakalau.controller.events.GameEvent;
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

			if (!gamesModel.getGameByID(gameVO.gameID)) {
				dispatcher.dispatchEvent(new GameEvent(GameEvent.NEW_GAME, gameVO));
			}
			else {
				dispatcher.dispatchEvent(new GameEvent(GameEvent.UPDATE_GAME, gameVO));
			}
		}
	}
}
