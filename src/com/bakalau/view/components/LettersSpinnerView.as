/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 13/03/13
 * Time: 22:53
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components
{
	import starling.display.Sprite;
	import starling.events.Event;



	public class LettersSpinnerView extends Sprite
	{
		public function LettersSpinnerView ()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
		}
	}
}
