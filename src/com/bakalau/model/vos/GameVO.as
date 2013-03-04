/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	import com.projectcocoon.p2p.vo.ClientVO;

	import flash.utils.Dictionary;



	public class GameVO
	{
		public var gameID :String;
		public var isInitialized :Boolean = false;
		public var clients :Vector.<ClientVO> = new <ClientVO>[];

		public var owner :ClientVO;
		public var categories :Vector.<CategoryVO> = new <CategoryVO>[];
		public var players :Vector.<ClientVO> = new <ClientVO>[];
		public var started :Boolean = false;

		public var answers :Dictionary = new Dictionary(true);


		public function get playersConnected () :int
		{
			return players.length;
		}


		public function hasPlayer (player :ClientVO) :Boolean
		{
			return players.some(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return player.groupID == clientVO.groupID;
			});
		}


		public function removePlayer (player :ClientVO) :void
		{
			var index :int = players.length;
			while (--index >= 0 && players[index].groupID != player.groupID) {
			}

			if (index >= 0) {
				players.splice(index, 1);
			}
		}


		public function updateAnswer (answer :AnswerVO) :void
		{
			if (!answers[answer.player]) {
				answers[answer.player] = new <AnswerVO>[];
			}

			var playerAnswers :Vector.<AnswerVO> = answers[answer.player];
			var index :int = playerAnswers.length;
			while (--index >= 0 && playerAnswers[index].categoryID != answer.categoryID) {
			}

			if (index >= 0) {
				playerAnswers[index].value = answer.value;
			}
			else {
				playerAnswers.push(answer);
			}
		}
	}
}
