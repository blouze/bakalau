/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.view.components.GameView;



	public class GameMediator
	{
		private var _view :GameView;


		[ViewAdded]
		public function viewAdded (gameView :GameView) :void
		{
			_view = gameView;
		}


		[ViewRemoved]
		public function viewRemoved (gameView :GameView) :void
		{
			_view = null;
		}
	}
}
