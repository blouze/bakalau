/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 20/03/13
 * Time: 13:43
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.commands.app
{
	import com.bakalau.controller.events.AnswerEvent;
	import com.bakalau.model.GameModel;
	import com.bakalau.model.VOs.AppMessageVO;



	public class PlayerFinnish
	{
		[Inject(source="gameModel")]
		public var gameModel :GameModel;


		[Execute]
		public function execute (event :AnswerEvent) :void
		{
			gameModel.sendToAllClients(AppMessageVO.PLAYER_FINNISH, gameModel.localClient);
		}
	}
}
