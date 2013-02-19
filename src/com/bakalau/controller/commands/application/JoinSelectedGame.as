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
	import com.bakalau.model.LocalNetworkModel;



	public class JoinSelectedGame
	{
		[Inject(source="localNetworkModel")]
		public var localNetworkModel :LocalNetworkModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			if (gamesModel.selectedGame != gamesModel.currentGame) {
				gamesModel.joinGame(gamesModel.selectedGame, localNetworkModel.channel.clientName);
				gamesModel.currentGame = gamesModel.selectedGame;
			}
		}
	}
}
