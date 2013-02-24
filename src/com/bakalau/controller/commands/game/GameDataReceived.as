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

		private var _appMessage :AppMessageVO = new AppMessageVO();
		private var _game :GameVO;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameMessage :GameMessageVO = GameMessageVO(event.data);
			_game = gameModel.game;

			var player :ClientVO;

			switch (gameMessage.type) {

				case GameMessageVO.NEW_PLAYER :
					player = ClientVO(gameMessage.data);
					if (!_game.hasPlayer(player)) {
						_game.players.push(player);
						sendMessage(AppMessageVO.GAME_UPDATE);
					}

					if (!_game.isInitialized) {
						_game.owner = gameModel.localPlayer;
						_game.isInitialized = true;
						sendMessage(AppMessageVO.NEW_GAME);
					}
					break;

				case GameMessageVO.PLAYER_QUIT :
					player = ClientVO(gameMessage.data);
					if (_game.hasPlayer(player)) {
						_game.removePlayer(player);

						if (player.groupID == _game.owner.groupID) {
							sendMessage(AppMessageVO.END_GAME);
						}
						else {
							sendMessage(AppMessageVO.GAME_UPDATE);
						}
					}
					break;

				case GameMessageVO.GAME_QUIT :
					break;

				default :
					break;
			}

			dispose();
		}


		private function sendMessage (messageType :String) :void
		{
			_appMessage.type = messageType;
			_appMessage.data = _game;
			appModel.channel.sendMessageToAll(_appMessage);
		}


		private function dispose () :void
		{
			_appMessage = null;
			_game = null;
		}
	}
}
