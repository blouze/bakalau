/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 13/03/13
 * Time: 00:04
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.hdi.nativeExtensions.NativeAds;
	import com.hdi.nativeExtensions.NativeAdsEvent;

	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.events.EventDispatcher;



	public class NativeAdsModel
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _adResolutionX :int;
		private var _adResolutionY :int;


		public function initAds (viewPort :Rectangle) :void
		{
			if (NativeAds.isSupported) {
				NativeAds.setUnitId("a1513f8eb81375a");
				NativeAds.setAdMode(true);//put the ads in real mode

				NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_RECEIVED, onAdReceived);
				NativeAds.dispatcher.addEventListener(NativeAdsEvent.AD_ERROR, onAdError);

				NativeAds.initAd(0, viewPort.height, _adResolutionX, _adResolutionY);
				NativeAds.showAd(0, viewPort.height, _adResolutionX, _adResolutionY);
			}
		}


		private function onAdReceived (event :NativeAdsEvent) :void
		{
			//Anything behind the ad will be hidden, update your layout to handle this edge case.
			trace("update ui's size and position");
		}


		private function onAdError (event :NativeAdsEvent) :void
		{
			trace(event.target);
		}


		public function get adResolutionX () :int
		{
			return _adResolutionX;
		}


		public function set adResolutionX (adResolutionX :int) :void
		{
			_adResolutionX = adResolutionX;
		}


		public function get adResolutionY () :int
		{
			return _adResolutionY;
		}


		public function set adResolutionY (value :int) :void
		{
			_adResolutionY = value;
		}
	}
}
