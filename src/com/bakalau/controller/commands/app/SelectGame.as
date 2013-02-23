/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 17:51
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.AppModel;



	public class SelectGame
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
//			var gameID :String = String(event.data);
//			gameModel.joinGame(gameID, appModel.playerName);
		}
	}
}
