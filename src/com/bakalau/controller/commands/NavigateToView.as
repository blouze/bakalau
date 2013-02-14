/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/10/12
 * Time: 21:42
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands
{
	import com.bakalau.controller.events.NavigationEvent;
	import com.creativebottle.starlingmvc.views.ViewManager;

	import starling.events.EventDispatcher;



	public class NavigateToView
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Inject]
		public var viewManager :ViewManager;


		[Execute]
		public function execute (event :NavigationEvent) :void
		{
			var viewClass :Class = event.viewClass;

			viewManager.setView(viewClass);
		}
	}
}
