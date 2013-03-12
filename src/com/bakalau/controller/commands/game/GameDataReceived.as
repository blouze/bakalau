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
	import com.bakalau.controller.events.NavEvent;
	import com.bakalau.model.AnswersModel;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.view.components.NavigatorView;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class GameDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Inject(source="answersModel")]
		public var answersModel :AnswersModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameMessage :GameMessageVO = GameMessageVO(event.data);

			var player :ClientVO;

			switch (gameMessage.type) {
				case AppMessageVO.START_GAME :
					gameModel.game.started = true;
					break;

				case GameMessageVO.PLAYER_QUIT :
					player = ClientVO(gameMessage.data);
					answersModel.removeAnswersByPlayerGroupID(player.groupID);
					break;

				case AppMessageVO.START_ROUND :
					answersModel.initAnswers(gameModel.game);
					if (gameModel.game.isLocalClientAPlayer) {
						dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_SCREEN, NavigatorView.GAME_MAIN));
					}
					break;

				case AppMessageVO.NEW_ANSWER :
					var answer :AnswerVO = AnswerVO(gameMessage.data);
					answersModel.updateAnswer(answer);
					break;

				case AppMessageVO.FINISH_ROUND :
					break;

				default :
					break;
			}

			gameModel.updateGame(gameMessage);

			if (gameModel.game.isLocalClientTheOwner) {
				if (gameMessage.type == AppMessageVO.START_GAME) {
					gameModel.sendToAllClients(AppMessageVO.START_ROUND);
				}
				else {
					appModel.sendToAllClients(AppMessageVO.UPDATE_GAME, gameModel.game)
				}
			}
			else if (!gameModel.game.owner) {

			}
		}
	}
}
