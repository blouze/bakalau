/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 12:37
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AnswerVO;



	public class GiveAnswer
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var answer :AnswerVO = AnswerVO(event.data);

			gameModel.giveAnswer(answer);
		}
	}
}
