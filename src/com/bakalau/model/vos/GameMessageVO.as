/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	public class GameMessageVO
	{
		private static const PREFIX :String = "GAME_MESSAGE_";
		public static const INITIALIZE :String = PREFIX + "INITIALIZE";
		public static const NEW_PLAYER :String = PREFIX + "NEW_PLAYER";
		public static const PLAYER_QUIT :String = PREFIX + "PLAYER_QUIT";
		public static const GAME_QUIT :String = PREFIX + "GAME_QUIT";

		public var type :String;
		public var data :*;
	}
}
