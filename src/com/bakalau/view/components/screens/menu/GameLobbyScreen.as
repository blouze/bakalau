/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.menu
{
	import com.bakalau.view.components.data.GameData;

	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
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
		public var onJoin :Signal = new Signal();
		public var onStart :Signal = new Signal();
		public var onQuit :Signal = new Signal();


		public function GameLobbyScreen ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _joinButton :Button;
		private var _startButton :Button;
		private var _quitButton :Button;
		private var _holdLabel :Label;
		private var _startedLabel :Label;

		private var _groupedListData :HierarchicalCollection = new HierarchicalCollection();
		private var _gameID :String;
		private var _gameStarted :Boolean;
		private var _ownerIsLocalPlayer :Boolean;
		private var _isJoined :Boolean;


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = _gameID;
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			var _groupedList :GroupedList = new GroupedList();
			_groupedList.dataProvider = _groupedListData;
			_groupedList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			_groupedList.isSelectable = false;
			_groupedList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild(_groupedList);

			_backButton = new Button();
			_backButton.label = "Retour";
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			_joinButton = new Button();
			_joinButton.label = "Rejoindre";
			_joinButton.addEventListener(Event.TRIGGERED, joinButton_triggeredHandler);

			_startButton = new Button();
			_startButton.label = "Commencer";
			_startButton.addEventListener(Event.TRIGGERED, startButton_triggeredHandler);

			_quitButton = new Button();
			_quitButton.label = "Quitter";
			_quitButton.addEventListener(Event.TRIGGERED, quitButton_triggeredHandler);

			_holdLabel = new Label();
			_holdLabel.text = "En attente ...";

			_startedLabel = new Label();
			_startedLabel.text = "En cours";

			backButtonHandler = onBackButton;
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
//				if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
//				}

				if (_isJoined) {
					headerProperties.leftItems = new <DisplayObject>[_quitButton];
					if (_ownerIsLocalPlayer) {
						headerProperties.rightItems = new <DisplayObject>[_startButton];
					}
					else {
						headerProperties.rightItems = new <DisplayObject>[_holdLabel];
					}
				}
				else {
					headerProperties.leftItems = new <DisplayObject>[_backButton];
					if (_gameStarted) {
						headerProperties.rightItems = new <DisplayObject>[_startedLabel];
					}
					else {
						headerProperties.rightItems = new <DisplayObject>[_joinButton];
					}
				}
			}
		}


		private function onBackButton () :void
		{
			dispatchEventWith(Event.COMPLETE);
		}


		private function backButton_triggeredHandler (event :Event) :void
		{
			onBackButton();
		}


		private function joinButton_triggeredHandler (event :Event) :void
		{
			onJoin.dispatch();
		}


		private function startButton_triggeredHandler (event :Event) :void
		{
			onStart.dispatch();
		}


		private function quitButton_triggeredHandler (event :Event) :void
		{
			onQuit.dispatch();
		}


		public function set gameData (value :GameData) :void
		{
			if (value.game) {
				_gameID = value.game.gameID;
				_gameStarted = value.game.started;
				_ownerIsLocalPlayer = value.gameOwnerIsLocalPlayer;
				_isJoined = value.isJoined;

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
}
