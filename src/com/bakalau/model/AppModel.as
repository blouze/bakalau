/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 18:05
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.model.managers.app.AppManager;
	import com.creativebottle.starlingmvc.binding.Bindings;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class AppModel
	{
		[Bindings]
		public var bindings :Bindings;

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
			if (!getGameByID(game.gameID)) {
				_games.push(game);
				bindings.invalidate(this, "games");
			}
		}


		public function updateGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				var existingGame :GameVO = _games[gameIndex];
				existingGame.categories = game.categories;
				existingGame.players = game.players;
//				_games[gameIndex] = gameVO;
			}
		}


		public function removeGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				_games.splice(gameIndex, 1);
				bindings.invalidate(this, "games");
			}
		}


		public function getGameByID (gameID :String) :GameVO
		{
			var filteredGames :Vector.<GameVO> = _games.filter(function (gameVO :GameVO, index :int, vector :Vector.<GameVO>) :Boolean
			{
				return gameVO.gameID == gameID;
			});

			if (filteredGames.length > 0) {
				return filteredGames.pop();
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
