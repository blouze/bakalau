/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:49
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;

	import starling.events.EventDispatcher;



	public class StartGame
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			if (gameModel.game.owner != appModel.player) {
				gameModel.playGame();
			}
			else {
				var appMessage :AppMessageVO = new AppMessageVO();
				appMessage.type = AppMessageVO.START_GAME;
				appMessage.data = gameModel.game;
				appModel.channel.sendMessageToAll(appMessage);
			}
		}
	}
}
