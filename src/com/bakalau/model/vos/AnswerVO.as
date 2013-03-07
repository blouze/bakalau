/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 01/03/13
 * Time: 12:30
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	import com.projectcocoon.p2p.vo.ClientVO;



	public class AnswerVO
	{
		public var category :CategoryVO;
		public var player :ClientVO;
		public var value :String;


		public function get categoryName () :String
		{
			return category.name;
		}
	}
}
