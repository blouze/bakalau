/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 17:51
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.application
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.GamesModel;



	public class SelectGame
	{
		[Inject(source="gamesModel")]
		public var gamesModel :GamesModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
			var gameID :String = String(event.data);

			gamesModel.selectedGame = gamesModel.getGameByID(gameID);
			gamesModel.bindings.invalidate(gamesModel, "selectedGame");
		}
	}
}
