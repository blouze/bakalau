/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 05/03/13
 * Time: 14:39
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.vo.ClientVO;

	import flash.utils.Dictionary;

	import starling.events.EventDispatcher;



	public class AnswersModel
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _answers :Dictionary;


		public function initAnswers (game :GameVO) :void
		{
			_answers = new Dictionary(true);

			for each (var player :ClientVO in game.players) {
				var answers :Vector.<AnswerVO> = new <AnswerVO> [];
				for each (var category :CategoryVO in game.categories) {
					var answer :AnswerVO = new AnswerVO();
					answer.category = category;
					answer.player = player;
					answers.push(answer);
				}
				_answers[player] = answers;
			}

//			dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.INITIALIZED, _answers));
		}


		public function updateAnswer (answer :AnswerVO) :void
		{
			_answers[answer.category] = answer;

			dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.NEW, _answers[answer.category]));
		}
	}
}
