/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/03/13
 * Time: 19:08
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.AppModel;
	import com.bakalau.model.NativeAdsModel;

	import feathers.system.DeviceCapabilities;

	import flash.geom.Rectangle;

	import starling.core.Starling;



	public class InitNativeAds
	{
		[Inject(source="nativeAdsModel")]
		public var nativeAdsModel :NativeAdsModel;

		[Inject(source="appModel")]
		public var appModel :AppModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			if (DeviceCapabilities.dpi >= 320) {
				nativeAdsModel.adResolutionX = 1280;
				nativeAdsModel.adResolutionY = 200;
			}
			else if (DeviceCapabilities.dpi >= 240) {
				nativeAdsModel.adResolutionX = 640;
				nativeAdsModel.adResolutionY = 100;
			}
			else if (DeviceCapabilities.dpi >= 160) {
				nativeAdsModel.adResolutionX = 320;
				nativeAdsModel.adResolutionY = 50;
			}
			else {
				nativeAdsModel.adResolutionX = 240;
				nativeAdsModel.adResolutionY = 37;
			}

			var viewPort :Rectangle = Starling.current.viewPort;
			viewPort.height -= nativeAdsModel.adResolutionY;
			appModel.resizeStarling(viewPort);
			nativeAdsModel.initAds(Starling.current.viewPort);
		}
	}
}
