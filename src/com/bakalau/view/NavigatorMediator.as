/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 10:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.NavigatorView;



	public class NavigatorMediator
	{
		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			if (_view) {
				_view.updateGame(value);
			}
		}


		[EventHandler(event="NavEvent.NAVIGATE_TO_SCREEN", properties="data")]
		public function onNavEvent (value :String) :void
		{
			if (_view) {
				_view.navigateToScreen(value);
			}
		}


		private var _view :NavigatorView;


		[ViewAdded]
		public function viewAdded (navigatorView :NavigatorView) :void
		{
			_view = navigatorView;
		}


		[ViewRemoved]
		public function viewRemoved (navigatorView :NavigatorView) :void
		{
			_view = null;
		}
	}
}
