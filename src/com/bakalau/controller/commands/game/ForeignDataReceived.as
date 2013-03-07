/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 07/03/13
 * Time: 13:27
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.AnswersModel;
	import com.bakalau.model.VOs.AnswerVO;



	public class ForeignDataReceived
	{
		[Inject(source="answersModel")]
		public var answersModel :AnswersModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var answer :AnswerVO = AnswerVO(event.data);

			answersModel.updateAnswer(answer);
		}
	}
}
