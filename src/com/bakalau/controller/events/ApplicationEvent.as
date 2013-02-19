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

		public static const SELECT_GAME :String = PREFIX + "SELECT_GAME";
		public static const START_SELECTED_GAME :String = PREFIX + "START_SELECTED_GAME";
		public static const JOIN_SELECTED_GAME :String = PREFIX + "JOIN_SELECTED_GAME";

		public static const CREATE_NEW_GAME :String = PREFIX + "CREATE_NEW_GAME";
		public static const NEW_GAME_CREATED :String = PREFIX + "NEW_GAME_CREATED";


		public function ApplicationEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
