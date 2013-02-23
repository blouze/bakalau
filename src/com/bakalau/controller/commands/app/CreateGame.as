/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class CreateGame
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
			var game :GameVO = GameVO(event.data);
			game.gameID = String(new Date().time);

			var message :AppMessageVO = new AppMessageVO();
			message.type = AppMessageVO.NEW_GAME;
			message.data = game;
			appModel.channel.sendMessageToAll(message);

			gameModel.joinGame(game, appModel.player.clientName);
		}
	}
}
