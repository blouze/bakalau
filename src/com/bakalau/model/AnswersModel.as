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
		private var _progresses :Dictionary;


		public function initAnswers (game :GameVO) :void
		{
			_answers = new Dictionary(true);
			_progresses = new Dictionary(true);

			for each (var player :ClientVO in game.players) {
				var answers :Vector.<AnswerVO> = new <AnswerVO> [];
				for each (var category :CategoryVO in game.categories) {
					var answer :AnswerVO = new AnswerVO();
					answer.category = category;
					answer.player = player;
					answer.value = "";
					answers.push(answer);
				}
				_answers[player.groupID] = answers;
				updatePlayerProgress(player.groupID);
			}

			dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.UPDATE, _answers));
			dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.PROGRESS, _progresses));
		}


		public function updateAnswer (answer :AnswerVO) :void
		{
			if (!answer) return;

			var playerAnswers :Vector.<AnswerVO> = _answers[answer.player.groupID];
			var index :int = playerAnswers.length;
			while (--index >= 0 && playerAnswers[index].category.rowid != answer.category.rowid) {
			}

			if (index >= 0) {
				playerAnswers[index] = answer;
				dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.UPDATE, _answers));

				updatePlayerProgress(answer.player.groupID);
				dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.PROGRESS, _progresses));
			}
		}


		private function updatePlayerProgress (playerGroupID :String) :void
		{
			var playerAnswers :Vector.<AnswerVO> = _answers[playerGroupID];

			_progresses[playerGroupID] = playerAnswers.filter(function (answerVO :AnswerVO, index :int, vector :Vector.<AnswerVO>) :Boolean
			{
				return answerVO.value != "";
			}).length;
		}


		public function removeAnswersByPlayerGroupID (playerGroupID :String) :void
		{
			if (!_answers) return;

			if (_answers[playerGroupID]) {
				delete _answers[playerGroupID];
				dispatcher.dispatchEvent(new AnswerEvent(AnswerEvent.UPDATE, _answers));
			}
		}


		public function get answers () :Dictionary
		{
			return _answers;
		}


		public function get progresses () :Dictionary
		{
			return _progresses;
		}
	}
}
