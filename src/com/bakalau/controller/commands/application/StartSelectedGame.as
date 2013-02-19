/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 12:49
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.application
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.controller.events.NavigationEvent;
	import com.bakalau.view.components.GameView;

	import starling.events.EventDispatcher;



	public class StartSelectedGame
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, GameView));
		}
	}
}
