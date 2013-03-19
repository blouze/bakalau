/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 15/03/13
 * Time: 10:28
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.DebriefScreenView;

	import starling.events.EventDispatcher;



	public class DebriefScreenMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}


		private var _view :DebriefScreenView;
		private var _game :GameVO;


		[ViewAdded]
		public function viewAdded (createGameScreen :DebriefScreenView) :void
		{
			_view = createGameScreen;
			_view.game = _game;
		}


		[ViewRemoved]
		public function viewRemoved (createGameScreen :DebriefScreenView) :void
		{
			_view = null;
		}
	}
}
