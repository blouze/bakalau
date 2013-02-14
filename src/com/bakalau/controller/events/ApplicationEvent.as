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
		public static const NEW_PLAYER_ADDED :String = PREFIX + "NEW_PLAYER_ADDED";
		public static const PLAYER_REMOVED :String = PREFIX + "PLAYER_REMOVED";
		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const JOIN_GAME :String = PREFIX + "JOIN_GAME";
		public static const GAME_CONNECTED :String = PREFIX + "GAME_CONNECTED";
		public static const NEW_GAME_ADDED :String = PREFIX + "NEW_GAME_ADDED";
		public static const DESTROY_GAME :String = PREFIX + "DESTROY_GAME";


		public function ApplicationEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
