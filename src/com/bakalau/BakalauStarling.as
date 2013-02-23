/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 13:06
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau
{
	import com.bakalau.controller.ControllerBeanProvider;
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.ModelBeanProvider;
	import com.bakalau.view.ViewBeanProvider;
	import com.creativebottle.starlingmvc.StarlingMVC;
	import com.creativebottle.starlingmvc.config.StarlingMVCConfig;
	import com.creativebottle.starlingmvc.views.ViewManager;

	import starling.display.Sprite;



	public class BakalauStarling extends Sprite
	{
		private var starlingMVC :StarlingMVC;


		public function BakalauStarling ()
		{
			super();

			var config :StarlingMVCConfig = new StarlingMVCConfig();
			config.eventPackages = ["com.bakalau.controller.events"];
			config.viewPackages = ["com.bakalau.view", "com.bakalau.view.components"];

			var beans :Array = [
				new ModelBeanProvider(),
				new ViewBeanProvider(),
				new ControllerBeanProvider(),
				new ViewManager(this)
			];

			starlingMVC = new StarlingMVC(this, config, beans);
			starlingMVC.dispatcher.dispatchEvent(new AppEvent(AppEvent.READY));
		}
	}
}
