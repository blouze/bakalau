/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.model.managers.gameChannel.GameChannelManager;
	import com.creativebottle.starlingmvc.binding.Bindings;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class GamesModel
	{
		[Bindings]
		public var bindings :Bindings;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _manager :GameChannelManager;
		private var _games :Vector.<GameVO> = new <GameVO>[];
		private var _selectedGame :GameVO;
		private var _localGame :GameVO;
		private var _currentGame :GameVO;


		public function joinGame (game :GameVO, playerID :String) :void
		{
			_manager = new GameChannelManager(game.gameID, playerID, dispatcher);
			_manager.channel.connect();
		}


		public function leaveGame () :void
		{
			_manager.dispose();
		}


		public function addNewGame (game :GameVO) :void
		{
			_games.push(game);
			bindings.invalidate(this, "games");
		}


		public function get manager () :GameChannelManager
		{
			return _manager;
		}


		public function get players () :Vector.<ClientVO>
		{
			if (_manager)
				return _manager.channel.clients;

			return null;
		}


		public function removeGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				_games.splice(gameIndex, 1);
			}
		}


		public function getGameByID (gameID :String) :GameVO
		{
			var gameVOs :Vector.<GameVO> = _games.filter(function (gameVO :GameVO, index :int, vector :Vector.<GameVO>) :Boolean
			{
				return (gameVO.gameID == gameID);
			});

			if (gameVOs.length > 0) {
				return gameVOs[0];
			}

			return null;
		}


		public function getGameIndex (game :GameVO) :int
		{
			var index :int = _games.length;
			while (--index) {
				if (_games[index].gameID == game.gameID) {
					return index;
				}
			}
			return index;
		}


		public function get games () :Vector.<GameVO>
		{
			return _games;
		}


		public function get selectedGame () :GameVO
		{
			return _selectedGame;
		}


		public function set selectedGame (value :GameVO) :void
		{
			_selectedGame = value;
		}


		public function get currentGame () :GameVO
		{
			return _currentGame;
		}


		public function set currentGame (value :GameVO) :void
		{
			_currentGame = value;
		}


		public function get localGame () :GameVO
		{
			return _localGame;
		}


		public function set localGame (value :GameVO) :void
		{
			_localGame = value;
		}
	}
}
