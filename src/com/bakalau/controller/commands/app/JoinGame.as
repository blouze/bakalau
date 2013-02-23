/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.GameVO;



	public class JoinGame
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			var game :GameVO = appModel.getGameByID(String(event.data));
			gameModel.joinGame(game, appModel.playerName);
		}
	}
}
