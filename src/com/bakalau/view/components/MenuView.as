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
	import com.bakalau.view.components.screens.menu.CreateGameScreen;
	import com.bakalau.view.components.screens.menu.GameLobbyScreen;
	import com.bakalau.view.components.screens.menu.GamesListScreen;
	import com.bakalau.view.components.screens.menu.HomeScreen;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.display.Sprite;
	import starling.events.Event;



	public class MenuView extends Sprite
	{
		private static const PREFIX :String = "SCREENS_VIEW_";
		public static const HOME :String = PREFIX + "HOME";
		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const LIST_GAMES :String = PREFIX + "LIST_GAMES";
		public static const GAME_LOBBY :String = PREFIX + "GAME_LOBBY";

		private var _theme :MetalWorksMobileTheme;
		private var _navigator :ScreenNavigator;
		private var _transitionManager :ScreenSlidingStackTransitionManager;

		public var createGame :Signal = new Signal(Vector.<int>);
		public var selectGame :Signal = new Signal(String);
		public var startSelectedGame :Signal = new Signal();
		public var joinSelectedGame :Signal = new Signal();

		private var _gamesData :GamesData = new GamesData();


		public function MenuView ()
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

//			Navigator
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
				onCreate: createGameScreen_onCreateGame,
				complete: LIST_GAMES
			}, {
				gamesData: _gamesData
			}));

//			GameLobbyScreen
			_navigator.addScreen(GAME_LOBBY, new ScreenNavigatorItem(GameLobbyScreen, {
				onStartGame: gameLobbyScreen_onStartGame,
				onJoinGame: gameLobbyScreen_onJoinGame,
				complete: LIST_GAMES
			}, {
				gamesData: _gamesData
			}));

//			TransitionManager
			_transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.5;
			_transitionManager.ease = Transitions.EASE_OUT;


			_navigator.showScreen(HOME);
		}


		private function createGameScreen_onCreateGame (categoryIDs :Vector.<int>) :void
		{
			createGame.dispatch(categoryIDs);
		}


		private function listGamesScreen_onSelectGame (gameID :String) :void
		{
			selectGame.dispatch(gameID);
		}


		private function gameLobbyScreen_onStartGame () :void
		{
			startSelectedGame.dispatch();
		}


		private function gameLobbyScreen_onJoinGame () :void
		{
			joinSelectedGame.dispatch();
		}


		public function set games (value :Vector.<GameVO>) :void
		{
			if (!value) return;

			_gamesData.updateGames(value);

			if (_navigator) {
				if (_navigator.activeScreenID == LIST_GAMES) {
					GamesListScreen(_navigator.activeScreen).gamesData = _gamesData;
				}
			}
		}


		public function set selectedGame (value :GameVO) :void
		{
			if (!value) return;

			_gamesData.selectedGame = value;
			_gamesData.updateCategories(value.categories);
			_gamesData.updatePlayers(value.players);

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
			if (!value) return;

			_gamesData.updateCategories(value);
		}
	}
}
