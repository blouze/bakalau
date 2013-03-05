/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.controller.events.NavEvent;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.model.managers.games.GameManager;
	import com.bakalau.view.components.GameView;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	/**
	 * GameModel provides interaction with a given game.
	 */
	public class GameModel
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _manager :GameManager;
		private var _game :GameVO;
		private var _localPlayer :ClientVO;


		/**
		 * Connect player to game's channel.
		 * @param game
		 * The game object to view.
		 * @param playerID
		 * The player groupID.
		 */
		public function viewGame (game :GameVO, playerID :String) :void
		{
			_game = game;

			_manager = new GameManager(playerID, _game.gameID, dispatcher);
			_manager.channel.connect();

			dispatcher.dispatchEvent(new GameEvent(GameEvent.UPDATE, _game));
		}


		/**
		 * Initialize game.
		 */
		public function initGame () :void
		{
			_game.owner = _localPlayer;
			_game.isInitialized = true;
		}


		/**
		 * Register player to current game.
		 */
		public function joinGame () :void
		{
			// _manager.channel.localClient is not updated quick enough, so...
			_localPlayer = _manager.channel.clients.filter(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return clientVO.isLocal;
			}).pop();

			if (!_game.isInitialized) {
				initGame();
			}

			sendToAllClients(GameMessageVO.PLAYER_JOIN, _localPlayer);
		}


		/**
		 * If player has joined game, tell all clients he's quitting.
		 * Disconnect player from current game, otherwise.
		 */
		public function leaveGame () :void
		{
			_manager.dispose();
			_localPlayer = null;
			_game = null;
			dispatcher.dispatchEvent(new GameEvent(GameEvent.UPDATE, _game));
		}


		/**
		 * Starts game.
		 */
		public function startGame () :void
		{
			sendToAllClients(GameMessageVO.START_GAME);
		}


		/**
		 * Quits game.
		 */
		public function quitGame () :void
		{
			sendToAllClients(GameMessageVO.PLAYER_QUIT, _localPlayer);
		}


		/**
		 * Update current game data and dispatch a data event.
		 * @param gameMessage
		 */
		public function updateGame (gameMessage :GameMessageVO) :void
		{
			var player :ClientVO;

			switch (gameMessage.type) {
				case GameMessageVO.PLAYER_JOIN :
					player = ClientVO(gameMessage.data);
					_game.addPlayer(player);
					dispatcher.dispatchEvent(new GameEvent(GameEvent.UPDATE, _game));
					break;

				case GameMessageVO.PLAYER_QUIT :
					player = ClientVO(gameMessage.data);
					if (player == _game.owner) {
						_game.removeAllPlayers();
					}
					else {
						_game.removePlayer(player);
					}
					dispatcher.dispatchEvent(new GameEvent(GameEvent.UPDATE, _game));
					break;

				case GameMessageVO.START_GAME :
					_game.started = true;
					if (_localPlayer && _game.hasPlayer(_localPlayer)) {
						dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_VIEW, GameView));
					}
					break;
				default :
					break;
			}
		}


		/**
		 * Send message to all clients connected to game's channel as a GameVO object.
		 * @param messageType
		 * @param messageData
		 */
		public function sendToAllClients (messageType :String, messageData :Object = null) :void
		{
			var message :GameMessageVO = new GameMessageVO();
			message.type = messageType;
			message.data = messageData;
			_manager.channel.sendMessageToAll(message);
		}


		/**
		 * @return The player's ClientVO.
		 */
		public function get localPlayer () :ClientVO
		{
			return _localPlayer;
		}


		/**
		 * @return The game created by player, if any.
		 */
		public function get playerOwnGame () :GameVO
		{
			return (_localPlayer && _game.owner == _localPlayer) ? _game : null;
		}


		/**
		 * The list of clients connected to current game.
		 */
		public function get clients () :Vector.<ClientVO>
		{
			return _manager ? _manager.channel.clients : null;
		}


		/**
		 * The current game object.
		 */
		public function get game () :GameVO
		{
			return _game;
		}
	}
}
