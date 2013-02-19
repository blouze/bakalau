/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import com.bakalau.model.VOs.GameVO;



	public class GameView
	{
		private var _game :GameVO;


		public function GameView ()
		{
		}


		public function set game (game :GameVO) :void
		{
			_game = game;
		}
	}
}
