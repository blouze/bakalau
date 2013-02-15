/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 12/02/13
 * Time: 00:18
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;



	public class GamesData
	{
		public var categories :Vector.<CategoryVO>;
		public var games :Vector.<GameVO>;
		public var selectedGame :GameVO;
		public var currentGame :GameVO;
	}
}
