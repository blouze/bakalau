/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 15:42
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.game
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.events.ClientEvent;



	public class RemovePlayer
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :GameEvent) :void
		{
			var clientEvent :ClientEvent = ClientEvent(event.data);

			var gameID :String = clientEvent.client.clientName;
			var playerGroupID :String = clientEvent.client.groupID;

			if (gameID) {
				trace("[RemovePlayer] " + playerGroupID + " from game " + gameID);

				var game :GameVO = gamesModel.getGameByID(gameID);
				if (game && !game.hasPlayerByGroupID(playerGroupID)) {
					game.players.push(playerGroupID);
					playersModel.channel.sendMessageToAll(game);
				}
			}
		}
	}
}
