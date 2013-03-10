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
		private var _progresses :Array;
		private var _hasPlayerFinished :Boolean;


		public function set answers (value :Dictionary) :void
		{
			_answers = value;

			if (value) {
				setProgresses();
			}
			else {
				_progresses = null;
			}
		}


		private function setProgresses () :void
		{
			_progresses = [];

			for (var playerGroupID :String in _answers) {
				var answers :Vector.<AnswerVO> = Vector.<AnswerVO>(_answers[playerGroupID]);
				var player :ClientVO = answers[0].player;
				var progress :Number = answers.filter(function (answerVO :AnswerVO, index :int, vector :Vector.<AnswerVO>) :Boolean
				{
					return answerVO.value != "";
				}).length;

				_progresses.push(new ListData(player.clientName, progress));

				if (player == _localPlayer) {
					_hasPlayerFinished = (progress == localAnswers.length);
				}
			}

			_progresses.sortOn("value", Array.NUMERIC);
			_progresses.reverse();
		}


		public function set game (value :GameVO) :void
		{
			_game = value;

			if (value) {
				for each (var player :ClientVO in _game.players) {
					if (player.isLocal) {
						_localPlayer = player;
						break;
					}
				}
			}
			else {
				_answers = null;
				_localPlayer = null;
			}
		}


		public function get localAnswers () :Vector.<AnswerVO>
		{
			if (_answers && _localPlayer) {
				return _answers[_localPlayer.groupID];
			}

			return null;
		}


		public function get progresses () :Array
		{
			return _progresses;
		}


		public function get hasPlayerFinished () :Boolean
		{
			return _hasPlayerFinished;
		}
	}
}
