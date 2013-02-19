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
		public var owner :ClientVO;
		public var players :Vector.<ClientVO> = new <ClientVO>[];
		// com.projectcocoon.p2p.vo.MessageVO
		// obviously cannot handle Vector.<String> over p2p connection


		public function get label () :String
		{
			return gameID;
		}


		public function get value () :String
		{
			return gameID;
		}


		public function hasPlayerByGroupID (playerGroupID :String) :Boolean
		{
			var players :Vector.<ClientVO> = players.filter(function (player :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return (player.groupID == playerGroupID);
			});

			return players.length > 0;
		}
	}
}
