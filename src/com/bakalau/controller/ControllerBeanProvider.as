/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:33
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller
{
	import com.bakalau.controller.commands.application.ApplicationReady;
	import com.bakalau.controller.commands.application.ClientAdded;
	import com.bakalau.controller.commands.application.ClientRemoved;
	import com.bakalau.controller.commands.application.CreateNewGame;
	import com.bakalau.controller.commands.application.GameDataReceived;
	import com.bakalau.controller.commands.application.JoinSelectedGame;
	import com.bakalau.controller.commands.application.SelectGame;
	import com.bakalau.controller.commands.application.StartSelectedGame;
	import com.bakalau.controller.commands.game.GameUpdate;
	import com.bakalau.controller.commands.navigation.NavigateToView;
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.controller.events.NavigationEvent;
	import com.creativebottle.starlingmvc.beans.BeanProvider;
	import com.creativebottle.starlingmvc.commands.Command;



	public class ControllerBeanProvider extends BeanProvider
	{
		public function ControllerBeanProvider ()
		{
			beans = [
				new Command(ApplicationEvent.READY, ApplicationReady),
				new Command(ApplicationEvent.CLIENT_ADDED, ClientAdded),
				new Command(ApplicationEvent.CLIENT_REMOVED, ClientRemoved),
				new Command(ApplicationEvent.GAME_DATA_RECEIVED, GameDataReceived),

				new Command(ApplicationEvent.CREATE_NEW_GAME, CreateNewGame),
				new Command(ApplicationEvent.SELECT_GAME, SelectGame),
				new Command(ApplicationEvent.START_SELECTED_GAME, StartSelectedGame),
				new Command(ApplicationEvent.JOIN_SELECTED_GAME, JoinSelectedGame),

				new Command(GameEvent.GAME_UPDATE, GameUpdate),

				new Command(NavigationEvent.NAVIGATE_TO_VIEW, NavigateToView)
			];
		}
	}
}
