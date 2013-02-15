/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.data.GamesData;
	import com.bakalau.view.components.screens.CreateGameScreen;
	import com.bakalau.view.components.screens.GameLobbyScreen;
	import com.bakalau.view.components.screens.GamesListScreen;
	import com.bakalau.view.components.screens.HomeScreen;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.display.Sprite;
	import starling.events.Event;



	public class ScreensView extends Sprite
	{
		private static const PREFIX :String = "SCREENS_VIEW_";
		public static const HOME :String = PREFIX + "HOME";
		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const LIST_GAMES :String = PREFIX + "LIST_GAMES";
		public static const GAME_LOBBY :String = PREFIX + "GAME_LOBBY";

		private var _theme :MetalWorksMobileTheme;
		private var _navigator :ScreenNavigator;
		private var _transitionManager :ScreenSlidingStackTransitionManager;

		private var _onScreenChange :Signal = new Signal(ScreenNavigator);

		public var createGame :Signal = new Signal();
		public var selectGame :Signal = new Signal(String);
		public var joinSelectedGame :Signal = new Signal();

		private var _gamesData :GamesData = new GamesData();


		public function get onScreenChange () :Signal
		{
			return _onScreenChange;
		}


		public function ScreensView ()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);


//			_theme = new AeonDesktopTheme(stage);
//			_theme = new AzureMobileTheme(stage, false);
			_theme = new MetalWorksMobileTheme(stage, false);
//			_theme = new MinimalMobileTheme(stage, false);


			_navigator = new ScreenNavigator();
			addChild(_navigator);

//			GamesMainScreen
			_navigator.addScreen(HOME, new ScreenNavigatorItem(HomeScreen, {
				onListGames: LIST_GAMES
			}));

//			JoinGameScreen
			_navigator.addScreen(LIST_GAMES, new ScreenNavigatorItem(GamesListScreen, {
				onCreateGame: CREATE_GAME,
				onSelectGame: listGamesScreen_onSelectGame,
				complete: HOME
			}, {
				gamesData: _gamesData
			}));

//			CreateGameScreen
			_navigator.addScreen(CREATE_GAME, new ScreenNavigatorItem(CreateGameScreen, {
				onConfirm: createGameScreen_onCreateGame,
				complete: LIST_GAMES
			}, {
				gamesData: _gamesData
			}));

//			GameLobbyScreen
			_navigator.addScreen(GAME_LOBBY, new ScreenNavigatorItem(GameLobbyScreen, {
				onJoinGame: gameLobbyScreen_onJoinGame,
				complete: LIST_GAMES
			}, {
				gamesData: _gamesData
			}));


			_transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.5;
			_transitionManager.ease = Transitions.EASE_OUT;


			_navigator.showScreen(HOME);
		}


		private function createGameScreen_onCreateGame () :void
		{
			createGame.dispatch();
		}


		private function listGamesScreen_onSelectGame (gameID :String) :void
		{
			selectGame.dispatch(gameID);
		}


		private function gameLobbyScreen_onJoinGame () :void
		{
			joinSelectedGame.dispatch();
		}


		public function set games (value :Vector.<GameVO>) :void
		{
			_gamesData.games = value;
			if (_navigator) {
				if (_navigator.activeScreenID == LIST_GAMES) {
					GamesListScreen(_navigator.activeScreen).gamesData = _gamesData;
				}
			}
		}


		public function set selectedGame (value :GameVO) :void
		{
			_gamesData.selectedGame = value;
			if (_navigator) {
				if (_navigator.activeScreenID == GAME_LOBBY) {
					GameLobbyScreen(_navigator.activeScreen).gamesData = _gamesData;
				}
				else {
					_navigator.showScreen(GAME_LOBBY);
				}
			}
		}


		public function set categories (value :Vector.<CategoryVO>) :void
		{
			_gamesData.categories = value;
		}
	}
}
