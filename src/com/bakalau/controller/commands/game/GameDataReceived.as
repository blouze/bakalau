/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 11:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class GameDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameMessage :GameMessageVO = GameMessageVO(event.data);

			var appMessage :AppMessageVO = new AppMessageVO();
			appMessage.type = AppMessageVO.GAME_UPDATE;

			var game :GameVO = gameModel.game;
			switch (gameMessage.type) {
				case GameMessageVO.INITIALIZE :
					game.owner = gameModel.localPlayer;
					game.isInitialized = true;
					appMessage.data = game;
					appModel.channel.sendMessageToAll(appMessage);
					break;

				case GameMessageVO.NEW_PLAYER :
					var player :ClientVO = ClientVO(gameMessage.data);
					if (!game.hasPlayer(player)) {
						game.players.push(player);
						appMessage.data = game;
						appModel.channel.sendMessageToAll(appMessage);
					}
					break;

				default :
					break;
			}
		}
	}
}
