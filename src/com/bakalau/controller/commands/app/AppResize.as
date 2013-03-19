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
	import com.bakalau.model.AppModel;
	import com.bakalau.model.CategoriesModel;

	import starling.events.EventDispatcher;



	public class AppResize
	{
//		[Inject(source="nativeAdsModel")]
//		public var nativeAdsModel :NativeAdsModel;

		[Inject(source="appModel")]
		public var appModel :AppModel;

		[Inject(source="categoriesModel")]
		public var categoriesModel :CategoriesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :AppEvent) :void
		{
//			nativeAdsModel.initAds(Starling.current.viewPort);
		}
	}
}
