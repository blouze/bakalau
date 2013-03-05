/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 12:37
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.answer
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.AnswersModel;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.CategoriesModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.AppMessageVO;



	public class UpdateAnswer
	{
		[Inject(source="categoriesModel")]
		public var categoriesModel :CategoriesModel;

		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Inject(source="answersModel")]
		public var answersModel :AnswersModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var data :Object = Object(event.data);

			var answer :AnswerVO = new AnswerVO();
			answer.category = categoriesModel.getCategoryByRowid(data.category_rowid);
			answer.player = gameModel.localPlayer;
			answer.value = data.answer_value;

			answersModel.updateAnswer(answer);
			appModel.sendToAllClients(AppMessageVO.ANSWER_GIVEN, answer);
		}
	}
}
