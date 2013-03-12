/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 12:37
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.answer
{
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.AppMessageVO;



	public class NewAnswer
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AnswerEvent) :void
		{
			var answer :AnswerVO = AnswerVO(event.data);
			answer.player = gameModel.localClient;

			gameModel.sendToAllClients(AppMessageVO.NEW_ANSWER, answer);
		}
	}
}
