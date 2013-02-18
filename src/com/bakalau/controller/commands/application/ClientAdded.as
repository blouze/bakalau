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

			var currentPlayerGame :GameVO = gamesModel.getGameByID(playersModel.currentPlayerName);

			if (currentPlayerGame) {
				trace("[ClientAdded] send game " + currentPlayerGame.gameID + " to " + newPlayer.groupID);
				playersModel.channel.sendMessageToClient(currentPlayerGame, newPlayer.groupID);
			}
		}
	}
}
