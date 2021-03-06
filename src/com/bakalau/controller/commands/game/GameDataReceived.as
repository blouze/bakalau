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
					gameModel.game.initRound();
					if (gameModel.game.isLocalClientInPlayers) {
						dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_SCREEN, NavigatorView.GAME_MAIN));
					}
					break;

				case AppMessageVO.NEW_ANSWER :
					var answer :AnswerVO = AnswerVO(gameMessage.data);
					answersModel.updateAnswer(answer);
					break;

				case AppMessageVO.PLAYER_FINNISH :
					player = ClientVO(gameMessage.data);
					gameModel.game.playersFinnished[player.groupID] = true;
					if (gameModel.game.hasEveryoneFinnished || answersModel.progresses[player.groupID] >= answersModel.answers[player.groupID].length) {
						gameModel.sendToAllClients(AppMessageVO.FINISH_ROUND);
					}
					break;

				case AppMessageVO.FINISH_ROUND :
					if (gameModel.game.isLocalClientInPlayers) {
						dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_SCREEN, NavigatorView.DEBRIEF_GAME));
					}
					break;

				default :
					break;
			}

			gameModel.updateGame(gameMessage);

			if (!gameModel.game.owner && gameModel.game.playersConnected > 0) {
				gameModel.game.owner = gameModel.game.players[0];
			}

			if (gameModel.game.isOwnedByLocalClient) {
				if (gameMessage.type == AppMessageVO.START_GAME) {
					gameModel.sendToAllClients(AppMessageVO.START_ROUND);
				}
				else {
					appModel.sendToAllClients(AppMessageVO.UPDATE_GAME, gameModel.game)
				}
			}
		}
	}
}
