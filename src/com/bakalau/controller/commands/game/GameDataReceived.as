/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 11:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.AnswersModel;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameMessageVO;



	public class GameDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Inject(source="answersModel")]
		public var answersModel :AnswersModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameMessage :GameMessageVO = GameMessageVO(event.data);

			if (gameMessage.type == GameMessageVO.START_GAME) {
				answersModel.initAnswers(gameModel.game);
			}

			gameModel.updateGame(gameMessage);

			if (gameModel.game.owner == gameModel.localPlayer) {
				appModel.sendToAllClients(AppMessageVO.UPDATE_GAME, gameModel.game)
			}
		}
	}
}
