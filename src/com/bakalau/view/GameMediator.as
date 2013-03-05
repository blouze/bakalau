/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.GameView;

	import starling.events.EventDispatcher;



	public class GameMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="DataEvent.GAME_UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}


		private var _view :GameView;
		private var _game :GameVO;


		[ViewAdded]
		public function viewAdded (gameView :GameView) :void
		{
			_view = gameView;
			_view.game = _game;

			_view.giveAnswer.add(function (answerCategory :String, answerValue :String) :void
			{
//				var answer :AnswerVO = new AnswerVO();
//				answer.categoryID = answerCategory;
//				answer.value = answerValue;
				dispatcher.dispatchEvent(new GameEvent(GameEvent.GIVE_ANSWER, {category_rowid: int(answerCategory), answer_value: answerValue}));
			});
		}


		[ViewRemoved]
		public function viewRemoved (gameView :GameView) :void
		{
			_view.giveAnswer.removeAll();

			_view.dispose();
			_view = null;

			_game = null;
		}
	}
}
