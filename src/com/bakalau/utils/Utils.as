/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 17:32
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.utils
{
	public class Utils
	{
		public static function vectorToArray (vector :Object) :Array
		{
			var result :Array = [];
			for (var i :int = 0; i < vector.length; ++i) {
				result[i] = vector[i];
			}
			return result;
		}
	}
}
