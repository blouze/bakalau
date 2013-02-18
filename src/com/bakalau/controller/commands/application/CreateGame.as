/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.application
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;

	import starling.events.EventDispatcher;



	public class CreateGame
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var game :GameVO = new GameVO();
			game.clientName = playersModel.currentPlayerName;

			playersModel.channel.sendMessageToAll(game);
		}
	}
}
