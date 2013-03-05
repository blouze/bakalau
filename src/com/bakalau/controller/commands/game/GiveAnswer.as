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
	import com.bakalau.model.DataBaseModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AnswerVO;



	public class GiveAnswer
	{
		[Inject(source="databaseModel")]
		public var databaseModel :DataBaseModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var data :Object = Object(event.data);
			var answer :AnswerVO = new AnswerVO();
			answer.category = databaseModel.getCategoryByRowid(data.category_rowid);
			answer.value = data.answer_value;

			gameModel.giveAnswer(answer);
		}
	}
}
