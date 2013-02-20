/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.GameView;



	public class GameMediator
	{
		private var _game :GameVO;
		[Inject(source="gamesModel.currentGame", bind="true", auto="false")]
		public function set game (value :GameVO) :void
		{
			_game = value;
			if (view) view.game = _game;
		}


		private var view :GameView;


		[ViewAdded]
		public function viewAdded (gameView :GameView) :void
		{
			view = gameView;
		}


		[ViewRemoved]
		public function viewRemoved (gameView :GameView) :void
		{
			view = null;
		}
	}
}
