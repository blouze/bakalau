/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 10:58
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.CreateScreenView;
	import com.bakalau.view.components.screens.DebriefScreenView;
	import com.bakalau.view.components.screens.GameScreenView;
	import com.bakalau.view.components.screens.GamesListScreenView;
	import com.bakalau.view.components.screens.HomeScreenView;
	import com.bakalau.view.components.screens.LobbyScreenView;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import flash.desktop.NativeApplication;

	import starling.animation.Transitions;
	import starling.display.Sprite;
	import starling.events.Event;



	public class NavigatorView extends Sprite
	{
		private static const PREFIX :String = "NAVIGATOR_SCREEN_";
		public static const HOME :String = PREFIX + "HOME";
		public static const LIST_GAMES :String = PREFIX + "LIST_GAMES";
		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const GAME_LOBBY :String = PREFIX + "GAME_LOBBY";
		public static const GAME_MAIN :String = PREFIX + "GAME_MAIN";
		public static const DEBRIEF_GAME :String = PREFIX + "DEBRIEF_GAME";

		private var _navigator :ScreenNavigator;


		public function NavigatorView ()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_navigator = new ScreenNavigator();

			addChild(_navigator);

			var _transitionManager :ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.5;
			_transitionManager.ease = Transitions.EASE_OUT;

			_navigator.addScreen(HOME, new ScreenNavigatorItem(HomeScreenView, {
				onListGames: LIST_GAMES,
				complete: backButtonPressed
			}));

			_navigator.addScreen(LIST_GAMES, new ScreenNavigatorItem(GamesListScreenView, {
				onCreate: CREATE_GAME,
				complete: HOME
			}));

			_navigator.addScreen(CREATE_GAME, new ScreenNavigatorItem(CreateScreenView, {
				complete: LIST_GAMES
			}));

			_navigator.addScreen(GAME_LOBBY, new ScreenNavigatorItem(LobbyScreenView, {
			}));

			_navigator.addScreen(GAME_MAIN, new ScreenNavigatorItem(GameScreenView, {
				complete: GAME_LOBBY
			}));

			_navigator.addScreen(DEBRIEF_GAME, new ScreenNavigatorItem(DebriefScreenView, {
				complete: GAME_LOBBY
			}));


			navigateToScreen(HOME);
		}


		public function navigateToScreen (screenID :String) :void
		{
			if (_navigator.activeScreenID != screenID) {
				_navigator.showScreen(screenID);
			}
		}


		public function updateGame (game :GameVO) :void
		{
			if (game) {
				if (!game.isLocalClientInPlayers) {
					navigateToScreen(NavigatorView.GAME_LOBBY);
				}
			}
			else {
				navigateToScreen(NavigatorView.LIST_GAMES);
			}
		}


		private function backButtonPressed () :void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}
