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
	import com.bakalau.view.components.data.CategoriesData;
	import com.bakalau.view.components.data.GameData;
	import com.bakalau.view.components.data.GamesListData;
	import com.bakalau.view.components.screens.menu.CreateGameScreen;
	import com.bakalau.view.components.screens.menu.GameLobbyScreen;
	import com.bakalau.view.components.screens.menu.GamesListScreen;
	import com.bakalau.view.components.screens.menu.HomeScreen;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

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
		public static const GAME_MAIN_SCREEN :String = PREFIX + "GAME_MAIN_SCREEN";

		private var _navigator :ScreenNavigator;

		public var createGame :Signal = new Signal(Vector.<int>);
		public var viewGame :Signal = new Signal(String);
		public var joinGame :Signal = new Signal();
		public var leaveGame :Signal = new Signal();
		public var startGame :Signal = new Signal();
		public var quitGame :Signal = new Signal();

		private var _categoriesData :CategoriesData = new CategoriesData();
		private var _gamesListData :GamesListData = new GamesListData();
		private var _gameData :GameData = new GameData();


		public function MenuView ()
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


//			GamesMainScreen
			_navigator.addScreen(HOME, new ScreenNavigatorItem(HomeScreen, {
				onListGames: LIST_GAMES
			}));

//			JoinGameScreen
			_navigator.addScreen(LIST_GAMES, new ScreenNavigatorItem(GamesListScreen, {
				onCreate: CREATE_GAME,
				onSelect: listGamesScreen_onSelect,
				complete: HOME
			}, {
				gamesListData: _gamesListData
			}));

//			CreateGameScreen
			_navigator.addScreen(CREATE_GAME, new ScreenNavigatorItem(CreateGameScreen, {
				onCreate: createGameScreen_onCreate,
				complete: LIST_GAMES
			}, {
				categoriesData: _categoriesData
			}));

//			GameLobbyScreen
			_navigator.addScreen(GAME_LOBBY, new ScreenNavigatorItem(GameLobbyScreen, {
				onJoin: gameLobbyScreen_onJoin,
				onStart: gameLobbyScreen_onStart,
				onQuit: gameLobbyScreen_onQuit,
				complete: gameLobbyScreen_onLeave
			}, {
				gameData: _gameData
			}));


			_navigator.showScreen(HOME);
		}


		private function createGameScreen_onCreate (categoryIDs :Vector.<int>) :void
		{
			createGame.dispatch(categoryIDs);
		}


		private function listGamesScreen_onSelect (gameID :String) :void
		{
			viewGame.dispatch(gameID);
		}


		private function gameLobbyScreen_onJoin () :void
		{
			joinGame.dispatch();
		}


		private function gameLobbyScreen_onStart () :void
		{
			startGame.dispatch();
		}


		private function gameLobbyScreen_onQuit () :void
		{
			quitGame.dispatch();
		}


		private function gameLobbyScreen_onLeave () :void
		{
			leaveGame.dispatch();
		}


		public function set categoriesList (value :Vector.<CategoryVO>) :void
		{
			_categoriesData.setCategories(value);
		}


		public function set gamesList (value :Vector.<GameVO>) :void
		{
			_gamesListData.setGames(value);

			if (_navigator) {
				if (_navigator.activeScreenID == LIST_GAMES) {
					GamesListScreen(_navigator.activeScreen).gamesListData = _gamesListData;
				}
			}
		}


		public function set game (value :GameVO) :void
		{
			_gameData.game = value;

			if (_navigator) {
				if (value) {
					if (_navigator.activeScreenID == GAME_LOBBY) {
						GameLobbyScreen(_navigator.activeScreen).gameData = _gameData;
					}
					else {
						_navigator.showScreen(GAME_LOBBY);
					}
				}
				else {
					_navigator.showScreen(LIST_GAMES);
				}
			}
		}
	}
}
