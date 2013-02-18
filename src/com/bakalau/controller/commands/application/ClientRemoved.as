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



	public class ClientRemoved
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var removedPlayer :ClientVO = ClientVO(event.data);
			var removedPlayerGame :GameVO = gamesModel.getGameByID(removedPlayer.clientName);

			if (removedPlayerGame) {
				trace("[ClientRemoved] removing client's game too");
				gamesModel.removeGame(removedPlayerGame);
			}
		}
	}
}
