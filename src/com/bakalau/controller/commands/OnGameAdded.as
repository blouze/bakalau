/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 12/02/13
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;
	import com.bakalau.model.PlayersModel;
	import com.bakalau.model.VOs.GameVO;



	public class OnGameAdded
	{
		[Inject(source="playersModel")]
		public var playersModel :PlayersModel;

		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var game :GameVO = GameVO(event.data);

			if (!gamesModel.getGameById(game.clientName, false)) {
				gamesModel.addGame(game);
			}
		}
	}
}
