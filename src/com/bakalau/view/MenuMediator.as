/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 09:57
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view
{
	import com.bakalau.controller.events.ApplicationEvent;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.MenuView;

	import starling.events.EventDispatcher;



	public class MenuMediator
	{
		private var _categories :Vector.<CategoryVO>;
		[Inject(source="dataBaseModel.categories", bind="true", auto="false")]
		public function set categories (value :Vector.<CategoryVO>) :void
		{
			_categories = value;
			if (view) view.categories = _categories;
		}


		private var _games :Vector.<GameVO>;
		[Inject(source="gamesModel.games", bind="true", auto="false")]
		public function set games (value :Vector.<GameVO>) :void
		{
			_games = value;
			if (view) view.games = _games;
		}


		private var _selectedGame :GameVO;
		[Inject(source="gamesModel.selectedGame", bind="true", auto="false")]
		public function set selectedGame (value :GameVO) :void
		{
			_selectedGame = value;
			if (view) view.selectedGame = _selectedGame;
		}


		[Dispatcher]
		public var dispatcher :EventDispatcher;


		private var view :MenuView;


		[ViewAdded]
		public function viewAdded (menuView :MenuView) :void
		{
			view = menuView;

			view.createGame.add(function (categoryIDs :Vector.<int>) :void
			{
				var newGame :GameVO = new GameVO();
				newGame.categories = _categories.filter(function (categoryVO :CategoryVO, index :int, vector :Vector.<CategoryVO>) :Boolean
				{
					return categoryIDs.lastIndexOf(categoryVO.rowid) >= 0;
				});
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CREATE_NEW_GAME, newGame));
			});

			view.selectGame.add(function (gameID :String) :void
			{
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.SELECT_GAME, gameID));
			});

			view.startSelectedGame.add(function () :void
			{
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.START_SELECTED_GAME));
			});

			view.joinSelectedGame.add(function () :void
			{
				dispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.JOIN_SELECTED_GAME));
			});

			view.games = _games;
			view.selectedGame = _selectedGame;
		}


		[ViewRemoved]
		public function viewRemoved (screensView :MenuView) :void
		{
			view.createGame.removeAll();
			view.selectGame.removeAll();
			view.startSelectedGame.removeAll();
			view.joinSelectedGame.removeAll();

			view.games = null;
			view.selectedGame = null;

			view = null;
		}
	}
}
