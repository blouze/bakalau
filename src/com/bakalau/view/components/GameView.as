/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.data.GameData;
	import com.bakalau.view.components.screens.game.GameMainScreen;
	import com.projectcocoon.p2p.vo.ClientVO;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import starling.animation.Transitions;
	import starling.display.Sprite;



	public class GameView extends Sprite
	{
		private static const PREFIX :String = "SCREENS_VIEW_";
		public static const GAME_MAIN :String = PREFIX + "GAME_MAIN";

		private var _navigator :ScreenNavigator;
		private var _transitionManager :ScreenSlidingStackTransitionManager;

		private var _gameData :GameData = new GameData();


		public function GameView ()
		{
			_navigator = new ScreenNavigator();
			addChild(_navigator);

			_transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.5;
			_transitionManager.ease = Transitions.EASE_OUT;

//			GamesMainScreen
			_navigator.addScreen(GAME_MAIN, new ScreenNavigatorItem(GameMainScreen, {
			}, {
				gameData: _gameData
			}));

			_navigator.showScreen(GAME_MAIN);
		}


		[Inject(source="gameModel.clients", bind="true", auto="false")]
		public function set clients (value :Vector.<ClientVO>) :void
		{
			_gameData.clients = value;
		}


		[Inject(source="gameModel.game", bind="true", auto="false")]
		public function set game (value :GameVO) :void
		{
			_gameData.game = value;

			if (_navigator) {
				if (_navigator.activeScreenID == GAME_MAIN) {
					GameMainScreen(_navigator.activeScreen).gameData = _gameData;
				}
			}
		}
	}
}
