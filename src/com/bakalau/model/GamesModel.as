/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.creativebottle.starlingmvc.binding.Bindings;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;

	import starling.events.EventDispatcher;



	public class GamesModel
	{
		private static var CLIENT_NAME :String = "CLIENT_NAME";

		[Bindings]
		public var bindings :Bindings;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _games :Vector.<GameVO> = new <GameVO>[];
		private var _currentGame :GameVO;


		public function joinGame (gameID :String) :void
		{
			var channel :LocalNetworkDiscovery = new LocalNetworkDiscovery();

			channel.clientName = gameID;

			channel.groupName = gameID;
			channel.loopback = true;
			channel.addEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			channel.addEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			channel.addEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			channel.addEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			channel.addEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);
			channel.connect();

			_currentGame = getGameById(gameID);
		}


		public function addGame (game :GameVO) :void
		{
			_games.push(game);
			bindings.invalidate(this, "games");
		}


		public function removeGame (game :GameVO) :void
		{
			var gameIndex :int = getGameIndex(game);
			if (gameIndex >= 0) {
				_games.splice(gameIndex, 1);
				bindings.invalidate(this, "games");
			}
		}


		public function getGameById (gameID :String, newGame :Boolean = true) :GameVO
		{
			var gameVOs :Vector.<GameVO> = _games.filter(function (gameVO :GameVO, index :int, vector :Vector.<GameVO>) :Boolean
			{
				return (gameVO.clientName == gameID);
			});

			if (gameVOs.length > 0) {
				return gameVOs[0];
			}
			else if (newGame) {
				var game :GameVO = new GameVO();
				game.clientName = gameID;
				return game;
			}

			return null;
		}


		public function getGameIndex (game :GameVO) :int
		{
			var index :int = _games.length;
			while (--index) {
				if (_games[index].clientName == game.clientName) {
					return index;
				}
			}
			return index;
		}


		private function onClientEvent (event :ClientEvent) :void
		{
			trace("[GamesModel] " + event.type);
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					trace("[GamesModel] clientName: " + event.client.clientName);
					trace("[GamesModel] peerID: " + event.client.peerID);
					break;

				case ClientEvent.CLIENT_UPDATE:
					trace("[GamesModel] clientName: " + event.client.clientName);
					trace("[GamesModel] peerID: " + event.client.peerID);
					break;

				case ClientEvent.CLIENT_REMOVED:
					break;

				default :
					break;
			}
		}


		private function onGroupEvent (event :GroupEvent) :void
		{
			trace("[GamesModel] " + event.type);
			switch (event.type) {
				case GroupEvent.GROUP_CONNECTED:
					var channel :LocalNetworkDiscovery = LocalNetworkDiscovery(event.target);
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.GAME_CONNECTED, channel.clientName));
					break;


				default :
					break;
			}
		}


		private function onMessageEvent (event :MessageEvent) :void
		{
			trace(event);
		}


		public function get games () :Vector.<GameVO>
		{
			return _games;
		}


		public function get currentGame () :GameVO
		{
			return _currentGame;
		}
	}
}
