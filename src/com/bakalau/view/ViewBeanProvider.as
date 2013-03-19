/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.view.GameScreenMediator;
	import com.creativebottle.starlingmvc.beans.BeanProvider;



	public class ViewBeanProvider extends BeanProvider
	{
		public function ViewBeanProvider ()
		{
			beans = [
				new NavigatorMediator(),
				new GamesListScreenMediator(),
				new CreateScreenMediator(),
				new LobbyScreenMediator(),
				new GameScreenMediator(),
				new DebriefScreenMediator(),
				new LettersSpinnerMediator()
			];
		}
	}
}
