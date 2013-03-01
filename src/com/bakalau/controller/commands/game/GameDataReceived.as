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
	import com.bakalau.controller.events.NavigationEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.GameView;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class GameDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _appMessage :AppMessageVO = new AppMessageVO();
		private var _game :GameVO;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameMessage :GameMessageVO = GameMessageVO(event.data);
			_game = gameModel.game;

			var player :ClientVO;

			switch (gameMessage.type) {

				case GameMessageVO.PLAYER_JOIN :
					player = ClientVO(gameMessage.data);
					if (!_game.hasPlayer(player)) {
						_game.players.push(player);
						if (!_game.isInitialized) {
							_game.owner = gameModel.localPlayer;
							_game.isInitialized = true;
							sendMessage(AppMessageVO.ADD_GAME);
						}
						else {
							sendMessage(AppMessageVO.UPDATE_GAME);
						}
					}
					break;

				case GameMessageVO.PLAYER_QUIT :
					player = ClientVO(gameMessage.data);
					if (player.groupID == _game.owner.groupID) {
						sendMessage(AppMessageVO.REMOVE_GAME);
					}
					else {
						_game.removePlayer(player);
						sendMessage(AppMessageVO.UPDATE_GAME);
					}
					break;

				case GameMessageVO.START_GAME :
					_game.started = true;
					if (gameModel.localPlayer && _game.hasPlayer(gameModel.localPlayer)) {
						dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, GameView));
					}
					sendMessage(AppMessageVO.UPDATE_GAME);
					break;

				default :
					break;
			}

			gameModel.bindings.invalidate(gameModel, "game");
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
