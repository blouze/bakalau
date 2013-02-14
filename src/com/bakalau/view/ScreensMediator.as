/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.vo.GameVO;
	import com.bakalau.view.components.ScreensView;

	import starling.events.EventDispatcher;



	public class ScreensMediator
	{
		private var _games :Vector.<GameVO>;

		[Inject(source="gamesModel.games", bind="true", auto="false")]
		public function set games (value :Vector.<GameVO>) :void
		{
			_games = value;
			if (view) view.games = _games;
		}


		private var _currentGame :GameVO;

		[Inject(source="gamesModel.currentGame", bind="true", auto="false")]
		public function set currentGame (value :GameVO) :void
		{
			_currentGame = value;
			if (view) view.currentGame = _currentGame;
		}


		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var view :ScreensView;


		[ViewAdded]
		public function viewAdded (screensView :ScreensView) :void
		{
			view = screensView;

			view.createGame.add(function () :void
			{
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CREATE_GAME));
			});
			view.joinGame.add(function (gameID :String) :void
			{
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.JOIN_GAME, gameID));
			});
			view.games = _games;
			view.currentGame = _currentGame;
		}


		[ViewRemoved]
		public function viewRemoved (screensView :ScreensView) :void
		{
			view.createGame.removeAll();
			view.joinGame.removeAll();
			view = null;
		}
	}
}
