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
	import com.bakalau.model.VOs.AppMessageVO;
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

			gameModel.game.clients = gameModel.clients;

//			if (leavingClient.groupID == gameModel.game.owner.groupID) {
//				gameModel.game.owner = (gameModel.game.players.length > 0) ? gameModel.game.players[0] : null;
//				gameModel.sendToAllClients(AppMessageVO.UPDATE_GAME, gameModel.game);
//			}

			if (gameModel.game.hasPlayer(leavingClient)) {
				gameModel.sendToAllClients(GameMessageVO.PLAYER_QUIT, leavingClient);
			}
		}
	}
}
