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



	public class AnswerEvent extends Event
	{
		private static const PREFIX :String = "ANSWER_";

		public static const UPDATE :String = PREFIX + "UPDATE";
		public static const PROGRESS :String = PREFIX + "PROGRESS";
		public static const NEW :String = PREFIX + "NEW";
		public static const PLAYER_FINISH :String = PREFIX + "PLAYER_FINISH";


		public function AnswerEvent (type :String, data :Object = null, bubbles :Boolean = false)
		{
			super(type, bubbles, data);
		}
	}
}
