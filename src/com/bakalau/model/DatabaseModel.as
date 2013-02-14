/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 11:13
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.managers.ICategoriesManager;
	import com.bakalau.model.managers.sqlite.SQLiteCategoriesManager;
	import com.creativebottle.starlingmvc.binding.Bindings;

	import flash.events.ErrorEvent;
	import flash.events.Event;



	public class DataBaseModel
	{
		[Bindings]
		public var bindings :Bindings;

		private var categoriesManager :ICategoriesManager = new SQLiteCategoriesManager();
		private var _categories :Vector.<CategoryVO>;


		public function DataBaseModel ()
		{
			categoriesManager.addEventListener(Event.COMPLETE, onManagerResult);
			categoriesManager.addEventListener(ErrorEvent.ERROR, onManagerError);
		}


		public function getCategories () :void
		{
			categoriesManager.loadCategories();
		}


		private function onManagerResult (event :Event) :void
		{
			_categories = categoriesManager.result;
			bindings.invalidate(this, "categories");
		}


		private function onManagerError (event :ErrorEvent) :void
		{
			trace(categoriesManager.error);
		}


		public function get categories () :Vector.<CategoryVO>
		{
			return _categories;
		}
	}
}
