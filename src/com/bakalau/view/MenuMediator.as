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
	import com.projectcocoon.p2p.vo.ClientVO;

	import starling.events.EventDispatcher;



	public class MenuMediator
	{
		[Dispatcher]
		public var dispatcher :EventDispatcher;


		[EventHandler(event="DataEvent.CATEGORIES_UPDATE", properties="data")]
		public function onCategoriesListUpdate (value :Vector.<CategoryVO>) :void
		{
			_categoriesList = value;
			if (_view) _view.categoriesList = _categoriesList;
		}


		[EventHandler(event="DataEvent.GAMES_LIST_UPDATE", properties="data")]
		public function onGamesListUpdate (value :Vector.<GameVO>) :void
		{
			_gamesList = value;
			if (_view) _view.gamesList = _gamesList;
		}


		[EventHandler(event="DataEvent.GAME_UPDATE", properties="data")]
		public function onGameUpdate (value :GameVO) :void
		{
			_game = value;
			if (_view) _view.game = _game;
		}




		private var _view :MenuView;
		private var _categoriesList :Vector.<CategoryVO>;
		private var _gamesList :Vector.<GameVO>;
		private var _game :GameVO;


		[ViewAdded]
		public function viewAdded (menuView :MenuView) :void
		{
			_view = menuView;
			_view.categoriesList = _categoriesList;
			_view.gamesList = _gamesList;
			_view.game = _game;

			_view.createGame.add(function (categoryIDs :Vector.<int>) :void
			{
				var newGame :GameVO = new GameVO();
				newGame.categories = _categoriesList.filter(function (categoryVO :CategoryVO, index :int, vector :Vector.<CategoryVO>) :Boolean
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
		public function viewRemoved (menuView :MenuView) :void
		{
			_view.createGame.removeAll();
			_view.joinGame.removeAll();
			_view.startGame.removeAll();
			_view.leaveGame.removeAll();
			_view.quitGame.removeAll();

			_view.dispose();
			_view = null;

			_categoriesList = null;
			_gamesList = null;
			_game = null;
		}
	}
}
