/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/10/12
 * Time: 22:27
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.controller.events
{
	import starling.events.Event;



	public class NavigationEvent extends Event
	{
		public static const NAME :String = "NAVIGATION_EVENT";
		public static const NAVIGATE_TO_VIEW :String = NAME + "_NAVIGATE_TO_VIEW";

		private var _viewClass :Class;


		public function NavigationEvent (type :String, data :Class = null)
		{
			super(type, false);
			_viewClass = data;
		}


		public function get viewClass () :Class
		{
			return _viewClass;
		}
	}
}
