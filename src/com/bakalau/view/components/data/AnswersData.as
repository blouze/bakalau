/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 12:28
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.vo.ClientVO;

	import flash.utils.Dictionary;



	public class AnswersData
	{
		private var _answers :Dictionary;
		private var _game :GameVO;
		private var _localPlayer :ClientVO;


		public function set answers (value :Dictionary) :void
		{
			_answers = value;
		}


		public function set game (value :GameVO) :void
		{
			_game = value;

			for each (var player :ClientVO in _game.players) {
				if (player.isLocal) {
					_localPlayer = player;
					break;
				}
			}
		}


		public function get localAnswers () :Vector.<AnswerVO>
		{
			if (_localPlayer) {
				return _answers[_localPlayer.groupID];
			}

			return null;
		}


		public function updateAnswer (newAnswer :AnswerVO) :void
		{
			var playerAnswers :Vector.<AnswerVO> = _answers[newAnswer.player.groupID];

			var index :int = playerAnswers.length;
			while (--index >= 0 && AnswerVO(playerAnswers[index]).category != newAnswer.category) {
			}

			if (index >= 0) {
				var answer :AnswerVO = AnswerVO(playerAnswers[index]);
				answer.value = newAnswer.value;
			}
		}
	}
}
