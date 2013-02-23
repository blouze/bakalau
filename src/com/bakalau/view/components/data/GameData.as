/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 12/02/13
 * Time: 00:18
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class GameData
	{
		private var _clients :Vector.<ClientVO>;
		private var _game :GameVO;

		private var _categories :Array = [];
		private var _players :Array = [];
		private var _localPlayer :ClientVO;


		public function set clients (value :Vector.<ClientVO>) :void
		{
			_clients = value;
		}


		public function get game () :GameVO
		{
			return _game;
		}


		public function set game (value :GameVO) :void
		{
			_game = value;

			setGameCategories(value.categories);
			setGamePlayers(value.players);
			setLocalPlayer();
		}


		public function get categories () :Array
		{
			return _categories;
		}


		private function setGameCategories (value :Vector.<CategoryVO>) :void
		{
			_categories = [];

			if (value) {
				for each (var categoryVO :CategoryVO in value) {
					_categories.push(new ListData(categoryVO.name, String(categoryVO.rowid)));
				}
			}
		}


		public function get players () :Array
		{
			return _players;
		}


		public function setGamePlayers (value :Vector.<ClientVO>) :void
		{
			_players = [];

			if (value) {
				for each (var player :ClientVO in value) {
					_players.push(new ListData(player.clientName, player.groupID));
				}
			}
		}


		public function setLocalPlayer () :void
		{
			_localPlayer = null;

			var localClients :Vector.<ClientVO> = _clients.filter(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return clientVO.isLocal;
			});

			if (localClients.length > 0) {
				_localPlayer = localClients.pop();
			}
		}


		public function get gameOwnerIsLocalPlayer () :Boolean
		{
			if (_localPlayer) {
				return _game.owner.groupID == _localPlayer.groupID;
			}

			return false;
		}


		public function get isJoined () :Boolean
		{
			if (_localPlayer) {
				return _game.players.filter(function (player :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
				{
					return player.groupID == _localPlayer.groupID;
				}).length > 0;
			}

			return false;
		}
	}
}
