/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/03/13
 * Time: 14:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.CreateScreenView;

	import starling.events.EventDispatcher;



	public class CreateScreenMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="DataEvent.CATEGORIES_UPDATE", properties="data")]
		public function onCategoriesUpdate (value :Vector.<CategoryVO>) :void
		{
			_categories = value;
			if (_view) _view.categories = _categories;
		}


		private var _view :CreateScreenView;
		private var _categories :Vector.<CategoryVO>;


		[ViewAdded]
		public function viewAdded (createGameScreen :CreateScreenView) :void
		{
			_view = createGameScreen;
			_view.categories = _categories;

			_view.onCreate.add(function (categoryIDs :Vector.<int>) :void
			{
				var newGame :GameVO = new GameVO();
				newGame.categories = _categories.filter(function (categoryVO :CategoryVO, index :int, vector :Vector.<CategoryVO>) :Boolean
				{
					return categoryIDs.lastIndexOf(categoryVO.rowid) >= 0;
				});
				dispatcher.dispatchEvent(new AppEvent(AppEvent.CREATE_GAME, newGame));
			});
		}


		[ViewRemoved]
		public function viewRemoved (createGameScreen :CreateScreenView) :void
		{
			_view = null;
		}


	}
}
