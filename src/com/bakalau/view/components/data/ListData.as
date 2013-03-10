/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 19/02/13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	public class ListData
	{
		private var _label :String;
		private var _value :Object;


		public function ListData (label :String, value :Object)
		{
			_label = label;
			_value = value;
		}


		public function get label () :String
		{
			return _label;
		}


		public function get value () :Object
		{
			return _value;
		}
	}
}
