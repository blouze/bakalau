/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.menu
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.data.GamesData;

	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.data.HierarchicalCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class GameLobbyScreen extends PanelScreen
	{
		public var onStartGame :Signal = new Signal();
		public var onJoinGame :Signal = new Signal();


		public function GameLobbyScreen ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _joinButton :Button;
		private var _startButton :Button;
		private var _groupedList :GroupedList;
		private var _groupedListData :HierarchicalCollection = new HierarchicalCollection(new Vector.<CategoryVO>());
		private var _game :GameVO;


		private function onInitialize (event :Event) :void
		{
//			headerProperties.title = _game.label;
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			_groupedList = new GroupedList();
			_groupedList.dataProvider = _groupedListData;
//			_groupedList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			_groupedList.isSelectable = false;
			_groupedList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild(_groupedList);

			if (true) {
//			if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
				_backButton = new Button();
				_backButton.label = "Retour";
				_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				headerProperties.leftItems = new <DisplayObject>
						[
							_backButton
						];

				if (_game.owner.isLocal) {
					_startButton = new Button();
					_startButton.label = "Commencer";
					_startButton.addEventListener(Event.TRIGGERED, startButton_triggeredHandler);

					headerProperties.rightItems = new <DisplayObject>
							[
								_startButton
							];
				}
				else {
					_joinButton = new Button();
					_joinButton.label = "Rejoindre";
					_joinButton.addEventListener(Event.TRIGGERED, joinButton_triggeredHandler);

					headerProperties.rightItems = new <DisplayObject>
							[
								_joinButton
							];
				}
			}
			backButtonHandler = onBackButton;
		}


		private function onBackButton () :void
		{
			dispatchEventWith(Event.COMPLETE);
		}


		private function backButton_triggeredHandler (event :Event) :void
		{
			onBackButton();
		}


		private function startButton_triggeredHandler (event :Event) :void
		{
			onStartGame.dispatch();
		}


		private function joinButton_triggeredHandler (event :Event) :void
		{
			onJoinGame.dispatch();
		}


		public function set gamesData (value :GamesData) :void
		{
			_game = value.selectedGame;

			_groupedListData.data = null;
			_groupedListData.data = [
				{
					header: "Joueurs :",
					children: value.players
				},
				{
					header: "Catégories :",
					children: value.categories
				}
			];

			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
