/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 16:06
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.events
{
	import starling.events.Event;



	public class DataEvent extends Event
	{
		private static const PREFIX :String = "DATA_";

		public static const CATEGORIES_UPDATE :String = PREFIX + "CATEGORIES_UPDATE";
		public static const GAMES_UPDATE :String = PREFIX + "GAMES_UPDATE";
		public static const GAME_UPDATE :String = PREFIX + "GAME_UPDATE";


		public function DataEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
