/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.GameView;

	import flash.utils.Dictionary;

	import starling.events.EventDispatcher;



	public class GameMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}


		[EventHandler(event="AnswerEvent.INITIALIZED", properties="data")]
		public function onAnswersInitialized (value :Dictionary) :void
		{
			_answers = value;
			if (_view) _view.answers = _answers;
		}


		[EventHandler(event="AnswerEvent.UPDATE", properties="data")]
		public function onAnswerUpdate (value :Dictionary) :void
		{
			_answers = value;
			if (_view) _view.answers = _answers;
		}


		private var _view :GameView;
		private var _game :GameVO;
		private var _answers :Dictionary;


		[ViewAdded]
		public function viewAdded (gameView :GameView) :void
		{
			_view = gameView;
			_view.game = _game;
			_view.answers = _answers;

			_view.giveAnswer.add(function (answerCategory :CategoryVO, answerValue :String) :void
			{
				var answer :AnswerVO = new AnswerVO();
				answer.category = answerCategory;
				answer.value = answerValue;
				dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.NEW, answer));
			});

			_view.quitGame.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.QUIT_GAME));
			});

			_view.finishGame.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.FINISH_ROUND));
			});
		}


		[ViewRemoved]
		public function viewRemoved (gameView :GameView) :void
		{
			_view.giveAnswer.removeAll();
			_view.quitGame.removeAll();

			_view.dispose();
			_view = null;
		}


		[PostDestroy]
		public function postDestroy () :void
		{
			_game = null;
			_answers = null;
		}
	}
}
