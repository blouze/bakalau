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



	public class GamesData
	{
		public var categories :Array = [];
		public var games :Vector.<ListData> = new <ListData>[];
		public var gameID :String;
		public var gameOwner :ClientVO;
		public var gameCategories :Array = [];
		public var players :Array = [];
		public var localPlayer :ClientVO;
		private var _isJoined :Boolean = false;


		public function updateCategories (value :Vector.<CategoryVO>) :void
		{
			categories = [];

			if (value) {
				for each (var categoryVO :CategoryVO in value) {
					var categoryName :String = capitalize(categoryVO.name);
					categories.push(new ListData(categoryName, String(categoryVO.rowid)));
				}
			}
		}


		public function updateGames (value :Vector.<GameVO>) :void
		{
			games = new <ListData>[];

			if (value) {
				for each (var game :GameVO in value) {
					games.push(new ListData("Partie " + game.gameID, game.gameID));
				}
			}
		}


		public function updateGameCategories (value :Vector.<CategoryVO>) :void
		{
			gameCategories = [];

			if (value) {
				for each (var categoryVO :CategoryVO in value) {
					var categoryName :String = capitalize(categoryVO.name);
					gameCategories.push(new ListData(categoryName, String(categoryVO.rowid)));
				}
			}
		}


		public function updatePlayers (value :Vector.<ClientVO>) :void
		{
			players = [];

			if (value) {
				for each (var playerVO :ClientVO in value) {
					players.push(new ListData(playerVO.clientName, playerVO.groupID));
				}

				_isJoined = value.some(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
				{
					return clientVO == localPlayer;
				});
			}
		}


		private function capitalize (inputStr :String) :String
		{
			var categoryBits :Array = inputStr.split("/");
			for each (var categoryBit :String in categoryBits) {
				categoryBit = String(String(categoryBit).substr(0, 1)).toUpperCase() + String(categoryBit).slice(1);
			}
			return categoryBits.join("/");
		}


		public function get isJoined () :Boolean
		{
			return _isJoined;
		}
	}
}
