/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 17:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GameModel;
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class NewClient
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var newClient :ClientVO = ClientVO(event.data);

			if (!gameModel.game.isInitialized) {
				dispatcher.dispatchEvent(new AppEvent(AppEvent.JOIN_GAME));
			}
		}
	}
}
