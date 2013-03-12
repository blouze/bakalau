/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 14:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.LobbyScreenView;

	import starling.events.EventDispatcher;



	public class LobbyScreenMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}


		private var _view :LobbyScreenView;
		private var _game :GameVO;


		[ViewAdded]
		public function viewAdded (gameLobbyScreen :LobbyScreenView) :void
		{
			_view = gameLobbyScreen;
			_view.game = _game;

			_view.onJoin.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.JOIN_GAME));
			});

			_view.onLeave.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.LEAVE_GAME));
			});

			_view.onStart.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.START_GAME));
			});

			_view.onQuit.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.QUIT_GAME));
			});
		}


		[ViewRemoved]
		public function viewRemoved (gameLobbyScreen :LobbyScreenView) :void
		{
			_view = null;
		}


		[PreDestroy]
		public function preDestroy () :void
		{
			_game = null;
		}
	}
}
