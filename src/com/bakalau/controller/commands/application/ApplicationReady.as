/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.application
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.controller.events.NavigationEvent;
	import com.bakalau.model.DataBaseModel;
	import com.bakalau.view.components.ScreensView;

	import starling.events.EventDispatcher;



	public class ApplicationReady
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

		[Inject(source="dataBaseModel")]
		public var dataBaseModel :DataBaseModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, ScreensView));
			dataBaseModel.getCategories();
		}
	}
}
