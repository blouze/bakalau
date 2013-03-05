/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 11:13
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model
{
	import com.bakalau.controller.events.DataEvent;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.managers.categories.ICategoriesManager;
	import com.bakalau.model.managers.categories.sqlite.SQLiteCategoriesManager;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.events.ErrorEvent;
	import flash.events.Event;

	import starling.events.EventDispatcher;



	public class DataBaseModel
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;

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


		public function getCategoryByRowid (category_rowid :int) :CategoryVO
		{
			var index :int = _categories.length;
			while (--index >= 0 && _categories[index].rowid != category_rowid) {
			}

			if (index >= 0) {
				return _categories[index];
			}

			return null;
		}


		private function onManagerResult (event :Event) :void
		{
			_categories = categoriesManager.result;
			dispatcher.dispatchEvent(new DataEvent(DataEvent.CATEGORIES_UPDATE, _categories));
		}


		private function onManagerError (event :ErrorEvent) :void
		{
			MonsterDebugger.log(event);
		}


		public function get categories () :Vector.<CategoryVO>
		{
			return _categories;
		}
	}
}
