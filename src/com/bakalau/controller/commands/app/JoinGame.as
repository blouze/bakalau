/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:49
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AnswersModel;
	import com.bakalau.model.GameModel;



	public class JoinGame
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Inject(source="answersModel")]
		public var answersModel :AnswersModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			gameModel.joinGame();
		}
	}
}
