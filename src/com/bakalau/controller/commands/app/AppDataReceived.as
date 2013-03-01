/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 21/02/13
 * Time: 10:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameVO;



	public class AppDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			var message :AppMessageVO = AppMessageVO(event.data);

			var game :GameVO = GameVO(message.data);

			switch (message.type) {
				case AppMessageVO.ADD_GAME :
					if (!appModel.getGameByID(game.gameID)) {
						appModel.addNewGame(game);
					}
					break;

				case AppMessageVO.UPDATE_GAME :
					appModel.updateGame(game);
					break;

				case AppMessageVO.REMOVE_GAME :
					if (gameModel.isCurrentGame(game)) {
						gameModel.leaveGame();
					}
					appModel.removeGame(game);
					break;

				default :
					break;
			}
		}
	}
}
