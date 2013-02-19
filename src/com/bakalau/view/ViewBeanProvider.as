/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.creativebottle.starlingmvc.beans.Bean;
	import com.creativebottle.starlingmvc.beans.BeanProvider;



	public class ViewBeanProvider extends BeanProvider
	{
		public function ViewBeanProvider ()
		{
			beans = [
				new Bean(new MenuMediator(), "menuMediator"),
				new Bean(new GameMediator(), "gameMediator")
			];
		}
	}
}
