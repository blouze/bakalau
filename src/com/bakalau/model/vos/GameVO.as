/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	public class GameVO
	{
		public var gameID :String;
		public var players :Vector.<Object> = new <Object>[];
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


		public function hasPlayerByGroupID (playerID :String) :Boolean
		{
			var players :Vector.<Object> = players.filter(function (playerName :String, index :int, vector :Vector.<Object>) :Boolean
			{
				return (playerName == playerID);
			});

			return players.length > 0;
		}
	}
}
