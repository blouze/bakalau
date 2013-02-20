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
		public var categories :Array;
		public var games :Vector.<ListData>;
		public var selectedGame :GameVO;
		public var players :Array;
		public var currentPlayerID :String;


		public function updateCategories (value :Vector.<CategoryVO>) :void
		{
			categories = [];

			for each (var categoryVO :CategoryVO in value) {
				var categoryName :String = capitalize(categoryVO.name);
				categories.push(new ListData(categoryName, String(categoryVO.rowid)));
			}
		}


		public function updateGames (value :Vector.<GameVO>) :void
		{
			games = new <ListData>[];

			for each (var gameVO :GameVO in value) {
				games.push(new ListData("Partie " + gameVO.gameID, gameVO.gameID));
			}
		}


		public function updatePlayers (value :Vector.<ClientVO>) :void
		{
			players = [];

			for each (var clientVO :ClientVO in value) {
				players.push(new ListData(clientVO.clientName, clientVO.groupID));
			}
		}


		public function hasPlayerJoined () :Boolean
		{
			return (players.filter(function (player :ListData, index :int, array :Array) :Boolean
			{
				return player.value == currentPlayerID;
			}).length) > 0;
		}


		private function capitalize (inputStr :String) :String
		{
			var categoryBits :Array = inputStr.split("/");
			for each (var categoryBit :String in categoryBits) {
				categoryBit = String(String(categoryBit).substr(0, 1)).toUpperCase() + String(categoryBit).slice(1);
			}
			return categoryBits.join("/");
		}
	}
}
