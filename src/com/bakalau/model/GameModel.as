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


		public function joinGame (game :GameVO, playerID :String) :void
		{
			_game = game;
			bindings.invalidate(this, "game");

			_manager = new GameManager(playerID, _game.gameID, dispatcher);
			_manager.channel.connect();
		}


		public function initGame () :void
		{
			var initMessage :GameMessageVO = new GameMessageVO();
			initMessage.type = GameMessageVO.INITIALIZE;
			_manager.channel.sendMessageToAll(initMessage);
		}


		public function playGame () :void
		{
			bindings.invalidate(this, "localPlayer");

			var message :GameMessageVO = new GameMessageVO();
			message.type = GameMessageVO.NEW_PLAYER;
			message.data = localPlayer;
			_manager.channel.sendMessageToAll(message);
		}


		public function leaveGame () :void
		{
			_manager.dispose();
			_game = null;
		}


		public function get localPlayer () :ClientVO
		{
			if (_manager) {
				if (_manager.channel.localClient) {
					return _manager.channel.localClient;
				}

				return _manager.channel.clients.filter(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
				{
					return clientVO.isLocal;
				}).pop();
			}

			return null;
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
