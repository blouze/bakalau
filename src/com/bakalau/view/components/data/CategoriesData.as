/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 23/02/13
 * Time: 18:25
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.data
{
	import com.bakalau.model.VOs.CategoryVO;



	public class CategoriesData
	{
		private var _categories :Array = [];


		public function get categories () :Array
		{
			return _categories;
		}


		public function setCategories (value :Vector.<CategoryVO>) :void
		{
			_categories = [];

			if (value) {
				for each (var categoryVO :CategoryVO in value) {
					_categories.push(new ListData(categoryVO.name, String(categoryVO.rowid)));
				}
			}
		}
	}
}
