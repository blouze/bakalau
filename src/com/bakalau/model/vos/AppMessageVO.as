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
		public static const ADD_GAME :String = PREFIX + "ADD_GAME";
		public static const UPDATE_GAME :String = PREFIX + "UPDATE_GAME";
		public static const REMOVE_GAME :String = PREFIX + "REMOVE_GAME";

		public var type :String;
		public var data :*;
	}
}
