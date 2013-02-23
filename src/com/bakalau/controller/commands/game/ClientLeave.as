/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 22/02/13
 * Time: 13:42
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class ClientLeave
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var leavingClient :ClientVO = ClientVO(event.data);

			if (gameModel.game.hasPlayer(leavingClient)) {
				gameModel.playerQuit(leavingClient);
			}
		}
	}
}
