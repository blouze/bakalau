/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/03/13
 * Time: 22:51
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.game.renderers
{
	import feathers.controls.ProgressBar;
	import feathers.controls.renderers.DefaultListItemRenderer;

	import starling.display.DisplayObject;



	public class PlayersListItemRenderer extends DefaultListItemRenderer
	{
		private var _progressBar :ProgressBar;


		override protected function initialize () :void
		{
			super.initialize();

			_progressBar = new ProgressBar();
			_progressBar.minimum = 0;

			labelField = "label";
			accessoryFunction = getProgressBar;
			accessoryLabelField = null;
		}


		override protected function draw () :void
		{
			super.draw();
		}


		public function set progressMax (value :String) :void
		{
			_progressBar.maximum = Number(value);
		}


		private function getProgressBar (item :Object) :DisplayObject
		{
			_progressBar.value = Number(item.value);
			return _progressBar;
		}
	}
}
