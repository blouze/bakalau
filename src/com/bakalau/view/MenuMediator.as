/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.AppEvent;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.MenuView;

	import starling.events.EventDispatcher;



	public class MenuMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var _categories :Vector.<CategoryVO>;
		[Inject(source="dataBaseModel.categories", bind="true", auto="false")]
		public function set categories (value :Vector.<CategoryVO>) :void
		{
			_categories = value;
			if (_view) _view.categories = value;
		}


		private var _view :MenuView;


		[ViewAdded]
		public function viewAdded (menuView :MenuView) :void
		{
			_view = menuView;

			_view.createGame.add(function (categoryIDs :Vector.<int>) :void
			{
				var newGame :GameVO = new GameVO();
				newGame.categories = _categories.filter(function (categoryVO :CategoryVO, index :int, vector :Vector.<CategoryVO>) :Boolean
				{
					return categoryIDs.lastIndexOf(categoryVO.rowid) >= 0;
				});
				dispatcher.dispatchEvent(new AppEvent(AppEvent.CREATE_GAME, newGame));
			});

			_view.joinGame.add(function (gameID :String) :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.JOIN_GAME, gameID));
			});

			_view.startGame.add(function () :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.START_GAME));
			});

			_view.leaveGame.add(function (gameID :String) :void
			{
				dispatcher.dispatchEvent(new AppEvent(AppEvent.LEAVE_GAME, gameID));
			});
		}


		[ViewRemoved]
		public function viewRemoved (screensView :MenuView) :void
		{
			_view.createGame.removeAll();
			_view.joinGame.removeAll();
			_view.startGame.removeAll();
			_view.leaveGame.removeAll();
			_view.quitGame.removeAll();

			_view = null;

			_categories = null;
		}
	}
}
