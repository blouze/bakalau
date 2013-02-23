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
		public static const NEW_GAME :String = PREFIX + "NEW_GAME";
		public static const GAME_UPDATE :String = PREFIX + "GAME_UPDATE";
		public static const START_GAME :String = PREFIX + "START_GAME";

		public var type :String;
		public var data :*;
	}
}
