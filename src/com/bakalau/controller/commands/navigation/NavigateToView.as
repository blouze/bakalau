/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/10/12
 * Time: 21:42
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.navigation
{
	import com.bakalau.controller.events.NavEvent;
	import com.creativebottle.starlingmvc.views.ViewManager;



	public class NavigateToView
	{
		[Inject]
		public var viewManager :ViewManager;


		[Execute]
		public function execute (event :NavEvent) :void
		{
			var viewClass :Class = event.viewClass;
			viewManager.setView(viewClass, null, true);
		}
	}
}
