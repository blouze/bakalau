/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:33
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller
{
	import com.bakalau.controller.commands.AddNewGameToGamesList;
	import com.bakalau.controller.commands.ApplicationReady;
	import com.bakalau.controller.commands.ClientAdded;
	import com.bakalau.controller.commands.ClientRemoved;
	import com.bakalau.controller.commands.CreateGame;
	import com.bakalau.controller.commands.GameCreated;
	import com.bakalau.controller.commands.GameJoined;
	import com.bakalau.controller.commands.JoinSelectedGame;
	import com.bakalau.controller.commands.NavigateToView;
	import com.bakalau.controller.commands.PlayerAdded;
	import com.bakalau.controller.commands.PlayerRemoved;
	import com.bakalau.controller.commands.PlayerUpdate;
	import com.bakalau.controller.commands.SelectGame;
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
				new Command(ApplicationEvent.CLIENT_ADDED, ClientAdded),
				new Command(ApplicationEvent.CLIENT_REMOVED, ClientRemoved),
				new Command(ApplicationEvent.CREATE_GAME, CreateGame),
				new Command(ApplicationEvent.SELECT_GAME, SelectGame),
				new Command(ApplicationEvent.JOIN_SELECTED_GAME, JoinSelectedGame),
				new Command(ApplicationEvent.GAME_CREATED, GameCreated),
				new Command(ApplicationEvent.GAME_JOINED, GameJoined),
				new Command(ApplicationEvent.ADD_NEW_GAME_TO_GAMES_LIST, AddNewGameToGamesList),
				new Command(ApplicationEvent.PLAYER_ADDED, PlayerAdded),
				new Command(ApplicationEvent.PLAYER_UPDATE, PlayerUpdate),
				new Command(ApplicationEvent.PLAYER_REMOVED, PlayerRemoved),

				new Command(NavigationEvent.NAVIGATE_TO_VIEW, NavigateToView)
			];
		}
	}
}
