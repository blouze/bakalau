/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:33
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller
{
	import com.bakalau.controller.commands.ApplicationReady;
	import com.bakalau.controller.commands.CreateGame;
	import com.bakalau.controller.commands.JoinGame;
	import com.bakalau.controller.commands.NavigateToView;
	import com.bakalau.controller.commands.OnGameAdded;
	import com.bakalau.controller.commands.OnGameConnected;
	import com.bakalau.controller.commands.OnPlayerAdded;
	import com.bakalau.controller.commands.OnPlayerRemoved;
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.controller.events.NavigationEvent;
	import com.creativebottle.starlingmvc.beans.BeanProvider;
	import com.creativebottle.starlingmvc.commands.Command;



	public class ControllerBeanProvider extends BeanProvider
	{
		public function ControllerBeanProvider ()
		{
			beans = [
				new Command(ApplicationEvent.READY, ApplicationReady),
				new Command(ApplicationEvent.NEW_PLAYER_ADDED, OnPlayerAdded),
				new Command(ApplicationEvent.PLAYER_REMOVED, OnPlayerRemoved),
				new Command(ApplicationEvent.CREATE_GAME, CreateGame),
				new Command(ApplicationEvent.JOIN_GAME, JoinGame),
				new Command(ApplicationEvent.GAME_CONNECTED, OnGameConnected),
				new Command(ApplicationEvent.NEW_GAME_ADDED, OnGameAdded),

				new Command(NavigationEvent.NAVIGATE_TO_VIEW, NavigateToView)
			];
		}
	}
}
