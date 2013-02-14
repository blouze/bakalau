/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.managers
{
	import com.bakalau.model.VOs.CategoryVO;

	import flash.errors.SQLError;
	import flash.events.IEventDispatcher;



	public interface ICategoriesManager extends IEventDispatcher
	{
		function loadCategories () :void


		function get result () :Vector.<CategoryVO>


		function get error () :SQLError
	}
}
