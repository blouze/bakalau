/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 13/03/13
 * Time: 22:55
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.view.components.LettersSpinnerView;



	public class LettersSpinnerMediator
	{
		[EventHandler(event="GameEvent.UPDATE", properties="data")]
		public function onLetterUpdate (value :String) :void
		{
			if (_view) {
			}
		}


		private var _view :LettersSpinnerView;


		[ViewAdded]
		public function viewAdded (lettersSpinnerView :LettersSpinnerView) :void
		{
			_view = lettersSpinnerView;
		}


		[ViewRemoved]
		public function viewRemoved (lettersSpinnerView :LettersSpinnerView) :void
		{
			_view = null;
		}
	}
}
