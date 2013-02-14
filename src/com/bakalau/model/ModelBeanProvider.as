/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:00
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.creativebottle.starlingmvc.beans.Bean;
	import com.creativebottle.starlingmvc.beans.BeanProvider;



	public class ModelBeanProvider extends BeanProvider
	{
		public function ModelBeanProvider ()
		{
			beans = [
				new Bean(new DataBaseModel(), "dataBaseModel"),
				new Bean(new PlayersModel(), "playersModel"),
				new Bean(new GamesModel(), "gamesModel")
			];
		}
	}
}
