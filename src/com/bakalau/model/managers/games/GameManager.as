/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 17:49
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.managers.games
{
	import com.bakalau.controller.events.GameEvent;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;

	import starling.events.EventDispatcher;



	public class GameManager
	{
		private var _channel :LocalNetworkDiscovery;
		private var _dispatcher :EventDispatcher;


		public function GameManager (playerID :String, gameID :String, dispatcher :EventDispatcher)
		{
			_dispatcher = dispatcher;

			_channel = new LocalNetworkDiscovery();
			_channel.clientName = playerID;
			_channel.groupName = gameID;
			_channel.loopback = true;

			_channel.addEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			_channel.addEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			_channel.addEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			_channel.addEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			_channel.addEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);
		}


		private function onClientEvent (event :ClientEvent) :void
		{
			trace(event);
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					_dispatcher.dispatchEvent(new GameEvent(GameEvent.NEW_CLIENT, event.client));
					break;

				case ClientEvent.CLIENT_UPDATE:
					break;

				case ClientEvent.CLIENT_REMOVED:
					break;

				default :
					break;
			}
		}


		private function onGroupEvent (event :GroupEvent) :void
		{
//			trace(event);
		}


		private function onMessageEvent (event :MessageEvent) :void
		{
			_dispatcher.dispatchEvent(new GameEvent(GameEvent.GAME_DATA_RECEIVED, event.message.data));
		}


		public function dispose () :void
		{
			_channel.removeEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			_channel.removeEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			_channel.removeEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			_channel.removeEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			_channel.removeEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);

			_channel.close();

			_channel = null;
			_dispatcher = null;
		}


		public function get channel () :LocalNetworkDiscovery
		{
			return _channel;
		}
	}
}
