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



	public class GameEvent extends Event
	{
		private static const PREFIX :String = "GAME_";

		public static const DATA_RECEIVED :String = PREFIX + "DATA_RECEIVED";
		public static const NEW_CLIENT :String = PREFIX + "NEW_CLIENT";
		public static const CLIENT_LEAVE :String = PREFIX + "CLIENT_LEAVE";
		public static const UPDATE :String = PREFIX + "UPDATE";


		public function GameEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
