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
	import com.bakalau.model.LocalNetworkModel;
	import com.bakalau.model.VOs.GameVO;



	public class CreateNewGame
	{
		[Inject(source="localNetworkModel")]
		public var localNetworkModel :LocalNetworkModel;


		[Execute]
		public function execute (event :ApplicationEvent) :void
		{
//			var newGame :GameVO = new GameVO();
			var newGame :GameVO = GameVO(event.data);
			newGame.gameID = String(new Date().time);
			newGame.owner = localNetworkModel.channel.localClient;
			localNetworkModel.channel.sendMessageToAll(newGame);
		}
	}
}
