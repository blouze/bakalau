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
	import com.projectcocoon.p2p.vo.ClientVO;



	public class ClientAdded
	{
		[Inject(source="localNetworkModel")]
		public var localNetworkModel :LocalNetworkModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var newPlayer :ClientVO = ClientVO(event.data);

			if (gamesModel.localGame) {
				trace("[ClientAdded] send game " + gamesModel.localGame.gameID + " to " + newPlayer.groupID);
				localNetworkModel.channel.sendMessageToClient(gamesModel.localGame, newPlayer.groupID);
			}
		}
	}
}
