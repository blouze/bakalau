/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 11:37
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.ListScreenView;

	import starling.events.EventDispatcher;



	public class ListScreenMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="DataEvent.GAMES_LIST_UPDATE", properties="data")]
		public function onGamesListUpdate (value :Vector.<GameVO>) :void
		{
			_games = value;
			if (_view) _view.games = _games;
		}


		private var _view :ListScreenView;
		private var _games :Vector.<GameVO>;


		[ViewAdded]
		public function viewAdded (gamesListScreen :ListScreenView) :void
		{
			_view = gamesListScreen;
			_view.games = _games;

			_view.onSelect.add(function (gameID :String) :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.VIEW_GAME, gameID));
			});
		}


		[ViewRemoved]
		public function viewRemoved (gamesListScreen :ListScreenView) :void
		{
			_view = null;
		}
	}
}
