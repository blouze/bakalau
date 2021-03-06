/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 20/02/13
 * Time: 15:52
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.GameModel;

	import starling.events.EventDispatcher;



	public class LeaveGame
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
			gameModel.leaveGame();
		}
	}
}
