/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	public class AppMessageVO
	{
		private static const PREFIX :String = "APP_MESSAGE_";
		public static const START_GAME :String = PREFIX + "START_GAME";
		public static const QUIT_GAME :String = PREFIX + "QUIT_GAME";
		public static const UPDATE_GAME :String = PREFIX + "UPDATE_GAME";
		public static const START_ROUND :String = PREFIX + "START_ROUND";
		public static const NEW_ANSWER :String = PREFIX + "NEW_ANSWER";
		public static const FINISH_ROUND :String = PREFIX + "FINISH_ROUND";

		public var type :String;
		public var data :*;
	}
}
