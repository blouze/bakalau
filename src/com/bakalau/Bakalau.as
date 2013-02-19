/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 11:56
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.registerClassAlias;

	import starling.core.Starling;



	public class Bakalau extends Sprite
	{
		public function Bakalau ()
		{
			trace("[Bakalau]");
			registerClassAlias("com.bakalau.model.VOs.CategoryVO", CategoryVO);
			registerClassAlias("com.bakalau.model.VOs.GameVO", GameVO);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			var starling :Starling = new Starling(BakalauStarling, stage);
			starling.start();
		}
	}
}
