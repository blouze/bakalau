/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.DataEvent;
	import com.bakalau.controller.events.NavEvent;
	import com.bakalau.model.VOs.AnswerVO;
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

			dispatcher.dispatchEvent(new DataEvent(DataEvent.GAME_UPDATE, _game));
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
			dispatcher.dispatchEvent(new DataEvent(DataEvent.GAME_UPDATE, _game));
		}


		/**
		 * Starts the game if player is game's owner.
		 * Put player on hold until game is started by owner, otherwise.
		 */
		public function startGame () :void
		{
			sendToAllClients(GameMessageVO.START_GAME);
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
					dispatcher.dispatchEvent(new DataEvent(DataEvent.GAME_UPDATE, _game));
					break;

				case GameMessageVO.PLAYER_QUIT :
					player = ClientVO(gameMessage.data);
					if (player == _game.owner) {
						_game.removeAllPlayers();
					}
					else {
						_game.removePlayer(player);
					}
					dispatcher.dispatchEvent(new DataEvent(DataEvent.GAME_UPDATE, _game));
					break;

				case GameMessageVO.START_GAME :
					_game.started = true;
					if (_localPlayer && _game.hasPlayer(_localPlayer)) {
						dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_VIEW, GameView));
					}
					break;

				case GameMessageVO.PLAYER_ANSWER :
					var answer :AnswerVO = AnswerVO(gameMessage.data);
					_game.updateAnswer(answer);
					break;

				default :
					break;
			}
		}


		/**
		 * Send answer data to all players.
		 * @param answer
		 */
		public function giveAnswer (answer :AnswerVO) :void
		{
			answer.player = _localPlayer;
			sendToAllClients(GameMessageVO.PLAYER_ANSWER, answer);
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
		 * @param game
		 * @return If player is connected to a given game.
		 */
		public function isCurrentGame (game :GameVO) :Boolean
		{
			return _game && _game.gameID == game.gameID;
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
		public function get selfOwnedGame () :GameVO
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
