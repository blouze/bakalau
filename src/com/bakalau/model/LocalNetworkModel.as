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
	import com.bakalau.model.VOs.GameVO;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;
	import com.projectcocoon.p2p.vo.ClientVO;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import starling.events.EventDispatcher;



	public class LocalNetworkModel
	{
		private const BAKALAU_CLIENT_NAME :String = "CLIENT";
		private const BAKALAU_GROUP_NAME :String = "BAKALAU";

		[Dispatcher]
		public var dispatcher :EventDispatcher;

		private var _players :Vector.<ClientVO> = new <ClientVO>[];
		private var _channel :LocalNetworkDiscovery;


		public function LocalNetworkModel ()
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
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					trace("[PlayersModel] CLIENT_ADDED: " + event.client.groupID);
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CLIENT_ADDED, event.client));
					break;

				case ClientEvent.CLIENT_UPDATE:
					break;

				case ClientEvent.CLIENT_REMOVED:
					trace("[PlayersModel] CLIENT_REMOVED: " + event.client.groupID);
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CLIENT_REMOVED, event.client));
					break;

				default :
					break;
			}
		}


		private function onGroupEvent (event :GroupEvent) :void
		{
			switch (event.type) {
				case GroupEvent.GROUP_CONNECTED:
					var channel :LocalNetworkDiscovery = LocalNetworkDiscovery(event.target);
					trace("[PlayersModel] CONNECTED_TO_GROUP: " + channel.groupName);
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
					dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.GAME_DATA_RECEIVED, event.message.data));
					break;

				default :
					trace("[PlayersModel] " + event.type + ": " + event.message.data);
					break;
			}
		}


		public function get channel () :LocalNetworkDiscovery
		{
			return _channel;
		}


		public function get localClientName () :String
		{
			if (channel.localClient) {
				return channel.localClient.clientName;
			}
			return null;
		}
	}
}
