/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 17:02
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.GameEvent;
	import com.bakalau.model.VOs.GameVO;
	import com.creativebottle.starlingmvc.binding.Bindings;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import starling.events.EventDispatcher;



	public class GamesModel
	{
		private static var CLIENT_NAME :String = "CLIENT_NAME";

		[Bindings]
		public var bindings :Bindings;

		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _games :Vector.<GameVO> = new <GameVO>[];
		private var _selectedGame :GameVO;
		private var _currentChannel :LocalNetworkDiscovery;
		private var _currentGame :GameVO;


		private function onClientEvent (event :ClientEvent) :void
		{
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					trace("[GamesModel] CLIENT_ADDED: " + event.client.clientName);
					dispatcher.dispatchEvent(new GameEvent(GameEvent.ADD_PLAYER, event.clone()));
					break;

				case ClientEvent.CLIENT_UPDATE:
					trace("[GamesModel] CLIENT_UPDATE: " + event.client.clientName);
					break;

				case ClientEvent.CLIENT_REMOVED:
					break;

				default :
					break;
			}
		}


		private function onGroupEvent (event :GroupEvent) :void
		{
			switch (event.type) {
				case GroupEvent.GROUP_CONNECTED:
					break;

				default :
					break;
			}
		}


		private function onMessageEvent (event :MessageEvent) :void
		{
			var dataClass :Class = Class(getDefinitionByName(getQualifiedClassName(event.message.data)));

			switch (dataClass) {
				default :
					trace("[GamesModel] " + event.type + ": " + event.message.data);
					break;
			}
		}


		public function joinGame (playerID :String, gameID :String) :void
		{
			_currentChannel = new LocalNetworkDiscovery();

			_currentChannel.clientName = playerID;
			_currentChannel.groupName = gameID;
			_currentChannel.loopback = true;

			_currentChannel.addEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			_currentChannel.addEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			_currentChannel.addEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			_currentChannel.addEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			_currentChannel.addEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);

			_currentChannel.connect();
		}


		public function leaveCurrentGame () :void
		{
			_currentChannel.close();

			_currentChannel.removeEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			_currentChannel.removeEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			_currentChannel.removeEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			_currentChannel.removeEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			_currentChannel.removeEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);

			_currentChannel = null;
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


		public function getGameByID (gameID :String) :GameVO
		{
			var gameVOs :Vector.<GameVO> = _games.filter(function (gameVO :GameVO, index :int, vector :Vector.<GameVO>) :Boolean
			{
				return (gameVO.clientName == gameID);
			});

			if (gameVOs.length > 0) {
				return gameVOs[0];
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


		public function get games () :Vector.<GameVO>
		{
			return _games;
		}


		public function get selectedGame () :GameVO
		{
			return _selectedGame;
		}


		public function set selectedGame (value :GameVO) :void
		{
			_selectedGame = value;
			bindings.invalidate(this, "selectedGame");
		}


		public function get currentChannel () :LocalNetworkDiscovery
		{
			return _currentChannel;
		}


		public function get currentGame () :GameVO
		{
			return _currentGame;
		}


		public function set currentGame (value :GameVO) :void
		{
			_currentGame = value;
			bindings.invalidate(this, "currentGame");
		}
	}
}
