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



	public class PlayerUpdate
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var player :ClientVO = ClientVO(event.data);

			// if player not already added to current game players
			var players :Vector.<Object> = gamesModel.currentGame.players.filter(function (playerID :String, index :int, vector :Vector.<Object>) :Boolean
			{
				return (playerID == player.clientName);
			});

			if (players.length == 0) {
				gamesModel.addPlayerToCurrentGame(player.clientName);
			}
		}
	}
}
