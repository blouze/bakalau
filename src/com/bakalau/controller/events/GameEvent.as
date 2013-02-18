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
		public static const NEW_GAME :String = PREFIX + "NEW_GAME";
		public static const UPDATE_GAME :String = PREFIX + "UPDATE_GAME";
		public static const UPDATE_PLAYERS :String = PREFIX + "UPDATE_PLAYERS";
		public static const REMOVE_PLAYER :String = PREFIX + "REMOVE_PLAYER";


		public function GameEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
