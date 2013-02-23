/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	import com.projectcocoon.p2p.vo.ClientVO;



	public class GameVO
	{
		public var gameID :String;
		public var isInitialized :Boolean = false;

		public var owner :ClientVO;
		public var categories :Vector.<CategoryVO> = new <CategoryVO>[];
		public var players :Vector.<ClientVO> = new <ClientVO>[];


		public function get playersConnected () :int
		{
			return players.length;
		}


		public function hasPlayer (player :ClientVO) :Boolean
		{
			return players.some(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return clientVO.groupID == player.groupID;
			});
		}


		public function get localPlayer () :ClientVO
		{
			var localPlayers :Vector.<ClientVO> = players.filter(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return clientVO.isLocal;
			});

			if (localPlayers.length > 0) {
				return localPlayers.pop();
			}

			return null;
		}
	}
}
