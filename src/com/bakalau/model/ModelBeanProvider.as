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

	import flash.system.Capabilities;



	public class ModelBeanProvider extends BeanProvider
	{
		public function ModelBeanProvider ()
		{
			beans = [
				new Bean(new CategoriesModel(), "categoriesModel"),
				new Bean(new AppModel(), "appModel"),
				new Bean(new GameModel(), "gameModel"),
				new Bean(new AnswersModel(), "answersModel")
			];

			if (Capabilities.cpuArchitecture == "ARM") {
				beans.push(new Bean(new NativeAdsModel(), "nativeAdsModel"));
			}
		}
	}
}
