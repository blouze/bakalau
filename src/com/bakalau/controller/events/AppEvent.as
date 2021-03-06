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



	public class AppEvent extends Event
	{
		private static const PREFIX :String = "APP_";

		public static const INIT_NATIVE_ADS :String = PREFIX + "INIT_NATIVE_ADS";
		public static const READY :String = PREFIX + "READY";
		public static const CLIENT_ADDED :String = PREFIX + "CLIENT_ADDED";

		public static const APP_DATA_RECEIVED :String = PREFIX + "APP_DATA_RECEIVED";
		public static const CREATE_GAME :String = PREFIX + "CREATE_GAME";
		public static const VIEW_GAME :String = PREFIX + "VIEW_GAME";
		public static const JOIN_GAME :String = PREFIX + "JOIN_GAME";
		public static const LEAVE_GAME :String = PREFIX + "LEAVE_GAME";
		public static const START_GAME :String = PREFIX + "START_GAME";
		public static const QUIT_GAME :String = PREFIX + "QUIT_GAME";
		public static const FINISH_ROUND :String = PREFIX + "FINISH_ROUND";


		public function AppEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
