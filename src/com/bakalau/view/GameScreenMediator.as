/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 19:33
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.GameScreenView;

	import flash.utils.Dictionary;

	import starling.events.EventDispatcher;



	public class GameScreenMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _game :GameVO;


		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}


		private var _answers :Dictionary;


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


		private var _view :GameScreenView;


		[ViewAdded]
		public function viewAdded (gameMainScreen :GameScreenView) :void
		{
			_view = gameMainScreen;
			_view.game = _game;
			_view.answers = _answers;

			_view.onAnswer.add(function (category :CategoryVO, value :String) :void
			{
				var answer :AnswerVO = new AnswerVO();
				answer.category = category;
				answer.value = value;
				dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.NEW, answer));
			});
		}


		[ViewRemoved]
		public function viewRemoved (gameMainScreen :GameScreenView) :void
		{
			_view = null;
		}


		[PreDestroy]
		public function preDestroy () :void
		{
			_game = null;
			_answers = null;
		}
	}
}
