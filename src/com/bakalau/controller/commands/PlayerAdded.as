/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 15:42
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.projectcocoon.p2p.vo.ClientVO;



	public class PlayerAdded
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			// if current player is joining his own game
			if (gamesModel.currentChannel.clientName == playersModel.currentPlayerName) {
				// update his currentGame with newly created game
				gamesModel.currentGame = gamesModel.getGameById(gamesModel.currentChannel.clientName);
			}

			var player :ClientVO = ClientVO(event.data);

			if (gamesModel.currentGame && gamesModel.currentGame.players.lastIndexOf(player.clientName) == -1) {
				gamesModel.addPlayerToCurrentGame(player.clientName);
			}
		}
	}
}
