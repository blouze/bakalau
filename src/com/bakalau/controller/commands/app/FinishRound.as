/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 10/03/13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;



	public class FinishRound
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AppEvent) :void
		{
			gameModel.sendToAllClients(AppMessageVO.FINISH_ROUND);
		}
	}
}
