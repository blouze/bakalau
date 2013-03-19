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
	import com.bakalau.controller.events.NavEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.CategoriesModel;
	import com.bakalau.view.components.NavigatorView;
	import com.bakalau.view.components.theme.BakalauTheme;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.EventDispatcher;



	public class ApplicationReady
	{
		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="categoriesModel")]
		public var categoriesModel :CategoriesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			var scaleToDPI :Boolean = (Capabilities.playerType != "Desktop" || Capabilities.isDebugger);
			new BakalauTheme(Starling.current.stage, scaleToDPI);

			if (Capabilities.cpuArchitecture != "ARM") {
				MonsterDebugger.initialize(this);
			}
			else {
				dispatcher.dispatchEvent(new AppEvent(AppEvent.INIT_NATIVE_ADS));
			}

			appModel.init();
			categoriesModel.getCategories();

			dispatcher.dispatchEvent(new NavEvent(NavEvent.NAVIGATE_TO_VIEW, NavigatorView));
		}
	}
}
