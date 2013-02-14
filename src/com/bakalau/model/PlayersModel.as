/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 18:05
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.vo.GameVO;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;
	import com.projectcocoon.p2p.vo.ClientVO;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import starling.events.EventDispatcher;



	public class PlayersModel
	{
		private const BAKALAU_CLIENT_NAME :String = "BAKALAU_CLIENT";
		private const BAKALAU_GROUP_NAME :String = "BAKALAU_GROUP";

		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _channel :LocalNetworkDiscovery;


		public function PlayersModel ()
		{
			_channel = new LocalNetworkDiscovery();
			_channel.clientName = BAKALAU_CLIENT_NAME + "_" + String(new Date().time);
			_channel.groupName = BAKALAU_GROUP_NAME;
			_channel.loopback = true;
			_channel.addEventListener(ClientEvent.CLIENT_ADDED, onClientEvent);
			_channel.addEventListener(ClientEvent.CLIENT_UPDATE, onClientEvent);
			_channel.addEventListener(ClientEvent.CLIENT_REMOVED, onClientEvent);
			_channel.addEventListener(GroupEvent.GROUP_CONNECTED, onGroupEvent);
			_channel.addEventListener(MessageEvent.DATA_RECEIVED, onMessageEvent);
			_channel.connect();
		}


		private function onClientEvent (event :ClientEvent) :void
		{
			trace("[PlayersModel] " + event.type);
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					trace("[PlayersModel] clientName: " + event.client.clientName);
					trace("[PlayersModel] peerID: " + event.client.peerID);
					trace("[PlayersModel] groupID: " + event.client.groupID);
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.NEW_PLAYER_ADDED, event.client));
					break;

				case ClientEvent.CLIENT_UPDATE:
					trace("[PlayersModel] clientName: " + event.client.clientName);
					trace("[PlayersModel] peerID: " + event.client.peerID);
					break;

				case ClientEvent.CLIENT_REMOVED:
					trace("[PlayersModel] clientName: " + event.client.clientName);
					trace("[PlayersModel] peerID: " + event.client.peerID);
					trace("[PlayersModel] groupID: " + event.client.groupID);
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.PLAYER_REMOVED, event.client));
					break;

				default :
					break;
			}
		}


		private function onGroupEvent (event :GroupEvent) :void
		{
			trace("[PlayersModel] " + event.type);
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
				case GameVO :
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.NEW_GAME_ADDED, event.message.data));
					break;

				case ClientVO :
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.DESTROY_GAME, event.message.data));
					break;

				default :
					trace(event.message.data);
					break;
			}
		}


		public function get channel () :LocalNetworkDiscovery
		{
			return _channel;
		}
	}
}
