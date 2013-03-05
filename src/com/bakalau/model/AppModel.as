/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 18:05
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.DataEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.model.managers.app.AppManager;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class AppModel
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _manager :AppManager;
		private var _games :Vector.<GameVO> = new <GameVO>[];


		public function init () :void
		{
			_manager = new AppManager(dispatcher);
		}


		public function get channel () :LocalNetworkDiscovery
		{
			return _manager.channel;
		}


		public function get player () :ClientVO
		{
			return _manager.channel.localClient;
		}


		public function get playerName () :String
		{
			return player.clientName;
		}


		public function get games () :Vector.<GameVO>
		{
			return _games;
		}


		public function addNewGame (game :GameVO) :void
		{
			_games.push(game);
			dispatcher.dispatchEvent(new DataEvent(DataEvent.GAMES_LIST_UPDATE, _games))
		}


		public function updateGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				_games[gameIndex] = game;
			}
		}


		public function removeGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				_games.splice(gameIndex, 1);
				dispatcher.dispatchEvent(new DataEvent(DataEvent.GAMES_LIST_UPDATE, _games))
			}
		}


		public function getGameByID (gameID :String) :GameVO
		{
			var index :int = _games.length;
			while (--index >= 0 && _games[index].gameID != gameID) {
			}

			if (index >= 0) {
				return _games[index];
			}

			return null;
		}


		public function getGameIndex (game :GameVO) :int
		{
			var index :int = _games.length;
			while (--index >= 0 && _games[index].gameID != game.gameID) {
			}
			return index;
		}
	}
}
