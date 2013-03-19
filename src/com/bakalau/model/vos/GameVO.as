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

		private var _clients :Vector.<ClientVO> = new <ClientVO>[];
		private var _localClient :ClientVO;

		public var owner :ClientVO;
		public var categories :Vector.<CategoryVO> = new <CategoryVO>[];
		public var players :Vector.<ClientVO> = new <ClientVO>[];
		public var started :Boolean = false;
		public var letters :Array;

		private var _currentLetter :String;


		public function get playersConnected () :int
		{
			return players.length;
		}


		public function hasPlayer (player :ClientVO) :Boolean
		{
			return players.some(function (clientVO :ClientVO, index :int, vector :Vector.<ClientVO>) :Boolean
			{
				return player.groupID == clientVO.groupID;
			});
		}


		public function addPlayer (player :ClientVO) :void
		{
			if (!hasPlayer(player)) {
				players.push(player);
				if (player.isLocal) {
					_localClient = player;
				}
			}
		}


		public function removePlayer (player :ClientVO) :void
		{
			var index :int = players.length;
			while (--index >= 0 && players[index].groupID != player.groupID) {
			}

			if (index >= 0) {
				players.splice(index, 1);
			}
		}


		public function removeAllPlayers () :void
		{
			while (players.length > 0) {
				players.pop();
			}
		}


		public function initLetters () :void
		{
			letters = [];

			for (var i :int = 65; i <= 90; i++) {
				letters.push(String.fromCharCode(i));
			}

			letters = letters.sort(function (a :*, b :*) :int
			{
				return ( Math.random() > .5 ) ? 1 : -1;
			});
		}


		public function nextLetter () :String
		{
			return _currentLetter = letters.shift();
		}


		public function get currentLetter () :String
		{
			return _currentLetter;
		}


		public function get localClient () :ClientVO
		{
			return _localClient;
		}


		public function get isLocalClientInPlayers () :Boolean
		{
			return _localClient && hasPlayer(_localClient);
		}


		public function get isOwnedByLocalClient () :Boolean
		{
			return _localClient && _localClient.groupID == owner.groupID;
		}
	}
}
