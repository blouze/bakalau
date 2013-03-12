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
	import com.demonsters.debugger.MonsterDebugger;

	import starling.display.Sprite;
	import starling.events.Event;



	public class BakalauStarling extends Sprite
	{
		public static var starlingMVC :StarlingMVC;


		public function BakalauStarling ()
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			var config :StarlingMVCConfig = new StarlingMVCConfig();
			config.eventPackages = ["com.bakalau.controller.events"];
			config.viewPackages = [
				"com.bakalau.view",
				"com.bakalau.view.components",
				"com.bakalau.view.components.screens"
			];

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
