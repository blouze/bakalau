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
	import com.bakalau.controller.events.NavigationEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.GameView;

	import starling.events.EventDispatcher;



	public class AppDataReceived
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			var message :AppMessageVO = AppMessageVO(event.data);

			var game :GameVO;

			switch (message.type) {
				case AppMessageVO.NEW_GAME :
					game = GameVO(message.data);
					appModel.addNewGame(game);
					break;

				case AppMessageVO.GAME_UPDATE :
					game = GameVO(message.data);
					appModel.updateGame(game);
					if (gameModel.game && gameModel.game.gameID == game.gameID) {
						gameModel.game = game;
						gameModel.bindings.invalidate(gameModel, "game");
					}
					break;

				case AppMessageVO.START_GAME :
					dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, GameView));
					break;

				default :
					break;
			}
		}
	}
}