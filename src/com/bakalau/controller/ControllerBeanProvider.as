/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:33
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller
{
	import com.bakalau.controller.commands.answer.NewAnswer;
	import com.bakalau.controller.commands.app.AppDataReceived;
	import com.bakalau.controller.commands.app.ApplicationReady;
	import com.bakalau.controller.commands.app.ClientAdded;
	import com.bakalau.controller.commands.app.CreateGame;
	import com.bakalau.controller.commands.app.FinishRound;
	import com.bakalau.controller.commands.app.InitNativeAds;
	import com.bakalau.controller.commands.app.JoinGame;
	import com.bakalau.controller.commands.app.LeaveGame;
	import com.bakalau.controller.commands.app.PlayerFinnish;
	import com.bakalau.controller.commands.app.QuitGame;
	import com.bakalau.controller.commands.app.StartGame;
	import com.bakalau.controller.commands.app.ViewGame;
	import com.bakalau.controller.commands.game.ClientLeave;
	import com.bakalau.controller.commands.game.GameDataReceived;
	import com.bakalau.controller.commands.game.NewClient;
	import com.bakalau.controller.commands.navigation.NavigateToView;
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.controller.events.NavEvent;
	import com.creativebottle.starlingmvc.beans.BeanProvider;
	import com.creativebottle.starlingmvc.commands.Command;

	import flash.system.Capabilities;



	public class ControllerBeanProvider extends BeanProvider
	{
		public function ControllerBeanProvider ()
		{
			beans = [
				new Command(AppEvent.READY, ApplicationReady),
				new Command(AppEvent.CLIENT_ADDED, ClientAdded),

				new Command(AppEvent.APP_DATA_RECEIVED, AppDataReceived),
				new Command(AppEvent.CREATE_GAME, CreateGame),
				new Command(AppEvent.VIEW_GAME, ViewGame),
				new Command(AppEvent.JOIN_GAME, JoinGame),
				new Command(AppEvent.LEAVE_GAME, LeaveGame),
				new Command(AppEvent.START_GAME, StartGame),
				new Command(AppEvent.QUIT_GAME, QuitGame),
				new Command(AppEvent.FINISH_ROUND, FinishRound),

				new Command(GameEvent.DATA_RECEIVED, GameDataReceived),
				new Command(GameEvent.NEW_CLIENT, NewClient),
				new Command(GameEvent.CLIENT_LEAVE, ClientLeave),

				new Command(AnswerEvent.NEW, NewAnswer),
				new Command(AnswerEvent.PLAYER_FINISH, PlayerFinnish),

				new Command(NavEvent.NAVIGATE_TO_VIEW, NavigateToView)
			];

			if (Capabilities.cpuArchitecture == "ARM") {
				beans.push(new Command(AppEvent.INIT_NATIVE_ADS, InitNativeAds));
			}
		}
	}
}
