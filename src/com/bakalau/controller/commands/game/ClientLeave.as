/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 17:26
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class ClientLeave
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var leavingClient :ClientVO = ClientVO(event.data);

			if (leavingClient != gameModel.localPlayer) {
				gameModel.game.clients = gameModel.clients;
			}
		}
	}
}
