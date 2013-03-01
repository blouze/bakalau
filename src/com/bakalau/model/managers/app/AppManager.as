/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 18/02/13
 * Time: 17:49
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.managers.app
{
	import com.bakalau.controller.events.AppEvent;
	import com.demonsters.debugger.MonsterDebugger;
	import com.projectcocoon.p2p.LocalNetworkDiscovery;
	import com.projectcocoon.p2p.events.ClientEvent;
	import com.projectcocoon.p2p.events.GroupEvent;
	import com.projectcocoon.p2p.events.MessageEvent;

	import starling.events.EventDispatcher;



	public class AppManager
	{
		private var _channel :LocalNetworkDiscovery;
		private var _dispatcher :EventDispatcher;


		public function AppManager (dispatcher :EventDispatcher)
		{
			_dispatcher = dispatcher;

			_channel = new LocalNetworkDiscovery();
			_channel.clientName = "CLIENT_" + String(new Date().time);
			_channel.groupName = "BAKALAU";
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
			MonsterDebugger.log(_channel);
			MonsterDebugger.log(event);
			switch (event.type) {
				case ClientEvent.CLIENT_ADDED:
					_dispatcher.dispatchEvent(new AppEvent(AppEvent.CLIENT_ADDED, event.client));
					break;

				case ClientEvent.CLIENT_UPDATE:
					break;

				case ClientEvent.CLIENT_REMOVED:
					_dispatcher.dispatchEvent(new AppEvent(AppEvent.CLIENT_REMOVED, event.client));
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
			_dispatcher.dispatchEvent(new AppEvent(AppEvent.APP_DATA_RECEIVED, event.message.data));
		}


		public function get channel () :LocalNetworkDiscovery
		{
			return _channel;
		}
	}
}
