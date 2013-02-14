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
	import com.bakalau.model.vo.GameVO;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class OnPlayerRemoved
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var removedPlayer :ClientVO = ClientVO(event.data);
			var removedPlayerGame :GameVO = gamesModel.getGameById(removedPlayer.clientName, false);

			if (removedPlayerGame) {
				gamesModel.removeGame(removedPlayerGame);
			}
		}
	}
}
