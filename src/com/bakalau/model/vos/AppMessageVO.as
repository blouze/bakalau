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
		public static const UPDATE_GAME :String = PREFIX + "UPDATE_GAME";
		public static const ANSWER_GIVEN :String = PREFIX + "ANSWER_GIVEN";

		public var type :String;
		public var data :*;
	}
}
