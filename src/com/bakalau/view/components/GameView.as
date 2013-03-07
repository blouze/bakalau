/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.data.AnswersData;
	import com.bakalau.view.components.data.GameData;
	import com.bakalau.view.components.screens.game.GameMainScreen;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

	import flash.utils.Dictionary;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.display.Sprite;



	public class GameView extends Sprite
	{
		private static const PREFIX :String = "SCREENS_VIEW_";
		public static const GAME_MAIN :String = PREFIX + "GAME_MAIN";

		private var _navigator :ScreenNavigator;

		public var giveAnswer :Signal = new Signal(CategoryVO, String);

		private var _gameData :GameData = new GameData();
		private var _answersData :AnswersData = new AnswersData();


		public function GameView ()
		{
			_navigator = new ScreenNavigator();
			addChild(_navigator);

			var _transitionManager :ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.5;
			_transitionManager.ease = Transitions.EASE_OUT;

//			GamesMainScreen
			_navigator.addScreen(GAME_MAIN, new ScreenNavigatorItem(GameMainScreen, {
				onAnswer: gameMainScreen_onAnswer
			}, {
				gameData: _gameData,
				answersData: _answersData
			}));

			_navigator.showScreen(GAME_MAIN);
		}


		private function gameMainScreen_onAnswer (category :CategoryVO, value :String) :void
		{
			giveAnswer.dispatch(category, value);
		}


		public function set game (value :GameVO) :void
		{
			_gameData.game = value;
			_answersData.game = _gameData.game;

			if (_navigator) {
				if (_navigator.activeScreenID == GAME_MAIN) {
					GameMainScreen(_navigator.activeScreen).gameData = _gameData;
				}
			}
		}


		public function set answers (value :Dictionary) :void
		{
			_answersData.answers = value;

			if (_navigator) {
				if (_navigator.activeScreenID == GAME_MAIN) {
					GameMainScreen(_navigator.activeScreen).answersData = _answersData;
				}
			}
		}
	}
}
