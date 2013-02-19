/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:54
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.VOs
{
	import com.projectcocoon.p2p.vo.ClientVO;



	public class GameVO
	{
		public var gameID :String;
		public var owner :ClientVO;
		public var categories :Vector.<CategoryVO> = new <CategoryVO>[];
		public var players :Vector.<ClientVO> = new <ClientVO>[];
	}
}
