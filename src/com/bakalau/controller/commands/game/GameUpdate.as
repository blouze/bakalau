/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 17:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.LocalNetworkModel;
	import com.bakalau.model.VOs.GameVO;



	public class GameUpdate
	{
		[Inject(source="localNetworkModel")]
		public var localNetworkModel :LocalNetworkModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var gameID :String = gamesModel.manager.channel.groupName;
			var game :GameVO = gamesModel.getGameByID(gameID);

			if (game.players.length != gamesModel.manager.channel.clients.length) {
				game.players = gamesModel.manager.channel.clients;
			}

			localNetworkModel.channel.sendMessageToAll(game);
		}
	}
}
