/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 03/02/13
 * Time: 02:30
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.events
{
	import starling.events.Event;



	public class ApplicationEvent extends Event
	{
		private static const PREFIX :String = "APPLICATION_";
		public static const READY :String = PREFIX + "READY";
		public static const CLIENT_ADDED :String = PREFIX + "CLIENT_ADDED";
		public static const CLIENT_REMOVED :String = PREFIX + "CLIENT_REMOVED";
		public static const GAME_DATA_RECEIVED :String = PREFIX + "GAME_DATA_RECEIVED";

		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const GAME_JOINED :String = PREFIX + "GAME_JOINED";
		public static const SELECT_GAME :String = PREFIX + "SELECT_GAME";
		public static const JOIN_SELECTED_GAME :String = PREFIX + "JOIN_SELECTED_GAME";
		public static const PLAYER_ADDED :String = PREFIX + "PLAYER_ADDED";
		public static const PLAYER_UPDATE :String = PREFIX + "PLAYER_UPDATE";
		public static const DESTROY_GAME :String = PREFIX + "DESTROY_GAME";


		public function ApplicationEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
