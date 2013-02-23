/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.controller.events.NavigationEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.DataBaseModel;
	import com.bakalau.view.components.MenuView;

	import starling.events.EventDispatcher;



	public class ApplicationReady
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="dataBaseModel")]
		public var dataBaseModel :DataBaseModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			appModel.init();
			dataBaseModel.getCategories();
			dispatcher.dispatchEvent(new NavigationEvent(NavigationEvent.NAVIGATE_TO_VIEW, MenuView));
		}
	}
}
