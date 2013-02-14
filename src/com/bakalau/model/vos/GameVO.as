/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	public class GameVO
	{
		public var clientName :String;
		public var players :Vector.<String>;


		public function get label () :String
		{
			return clientName;
		}


		public function get value () :String
		{
			return clientName;
		}
	}
}
