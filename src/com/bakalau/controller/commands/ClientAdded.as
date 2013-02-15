/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 16:21
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class ClientAdded
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var newPlayer :ClientVO = ClientVO(event.data);

			if (gamesModel.currentGame && gamesModel.currentGame.clientName == playersModel.currentPlayerName) {
				trace("[ClientAdded] send game " + gamesModel.currentGame.clientName + " to " + newPlayer.groupID);
				playersModel.channel.sendMessageToClient(gamesModel.currentGame, newPlayer.groupID);
			}
		}
	}
}
