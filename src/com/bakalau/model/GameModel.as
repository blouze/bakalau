/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.model.managers.games.GameManager;
	import com.creativebottle.starlingmvc.binding.Bindings;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class GameModel
	{
		[Bindings]
		public var bindings :Bindings;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _manager :GameManager;
		private var _game :GameVO;
		private var _localPlayer :ClientVO;


		public function visitGame (game :GameVO, playerID :String) :void
		{
			_game = game;
			bindings.invalidate(this, "game");

			_manager = new GameManager(playerID, _game.gameID, dispatcher);
			_manager.channel.connect();

			bindings.invalidate(this, "clients");
		}


		public function leaveGame () :void
		{
			_manager.dispose();

			_localPlayer = null;
			_game = null;
			bindings.invalidate(this, "game");
		}


		public function joinGame () :void
		{
			// _manager.channel.localClient is not updated quick enough, so...
			_localPlayer = _manager.channel.clients.filter(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return clientVO.isLocal;
			}).pop();

			var message :GameMessageVO = new GameMessageVO();
			message.type = GameMessageVO.PLAYER_JOIN;
			message.data = _localPlayer;
			_manager.channel.sendMessageToAll(message);
		}


		public function startGame () :void
		{
			var message :GameMessageVO = new GameMessageVO();
			message.type = GameMessageVO.START_GAME;
			_manager.channel.sendMessageToAll(message);
		}


		public function quitGame () :void
		{
			var message :GameMessageVO = new GameMessageVO();
			message.type = GameMessageVO.PLAYER_QUIT;
			message.data = _localPlayer;
			_manager.channel.sendMessageToAll(message);
		}


		public function isCurrentGame (game :GameVO) :Boolean
		{
			return _game && _game.gameID == game.gameID;
		}


		public function get localPlayer () :ClientVO
		{
			return _localPlayer;
		}


		public function get selfOwnedGame () :GameVO
		{
			return (_localPlayer && _game.owner == _localPlayer) ? _game : null;
		}


		public function get clients () :Vector.<ClientVO>
		{
			return _manager ? _manager.channel.clients : null;
		}


		public function get game () :GameVO
		{
			return _game;
		}


		public function set game (value :GameVO) :void
		{
			_game = value;
		}
	}
}
