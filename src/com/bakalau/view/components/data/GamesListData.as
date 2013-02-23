/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 23/02/13
 * Time: 18:21
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	import com.bakalau.model.VOs.GameVO;



	public class GamesListData
	{
		private var _games :Vector.<ListData> = new <ListData>[];


		public function setGames (value :Vector.<GameVO>) :void
		{
			_games = new <ListData>[];

			if (value) {
				for each (var game :GameVO in value) {
					_games.push(new ListData("Partie " + game.gameID, game.gameID));
				}
			}
		}


		public function get games () :Vector.<ListData>
		{
			return _games;
		}
	}
}
