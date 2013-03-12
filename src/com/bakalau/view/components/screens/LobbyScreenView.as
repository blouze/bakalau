/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.utils.Utils;
	import com.bakalau.view.components.NavigatorView;
	import com.bakalau.view.components.screens.renderers.GameLobbyListItemRenderer;

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



	public class LobbyScreenView extends PanelScreen
	{
		public var onJoin :Signal = new Signal();
		public var onLeave :Signal = new Signal();
		public var onStart :Signal = new Signal();
		public var onQuit :Signal = new Signal();


		public function LobbyScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _joinButton :Button;
		private var _startButton :Button;
		private var _resumeButton :Button;
		private var _quitButton :Button;
		private var _holdLabel :Label;
		private var _startedLabel :Label;

		private var _game :GameVO;
		private var _groupedListData :HierarchicalCollection = new HierarchicalCollection();


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = _game ? _game.gameID : "";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			var _groupedList :GroupedList = new GroupedList();
			_groupedList.dataProvider = _groupedListData;
			_groupedList.itemRendererType = GameLobbyListItemRenderer;
			_groupedList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			_groupedList.isSelectable = false;
			_groupedList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild(_groupedList);

			_backButton = new Button();
			_backButton.label = "Retour";
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			backButtonHandler = onBackButton;

			_joinButton = new Button();
			_joinButton.label = "Rejoindre";
			_joinButton.addEventListener(Event.TRIGGERED, joinButton_triggeredHandler);

			_startButton = new Button();
			_startButton.label = "Commencer";
			_startButton.addEventListener(Event.TRIGGERED, startButton_triggeredHandler);

			_resumeButton = new Button();
			_resumeButton.label = "Reprendre";
			_resumeButton.addEventListener(Event.TRIGGERED, resumeButton_triggeredHandler);

			_quitButton = new Button();
			_quitButton.label = "Quitter";
			_quitButton.addEventListener(Event.TRIGGERED, quitButton_triggeredHandler);

			_holdLabel = new Label();
			_holdLabel.text = "En attente ...";

			_startedLabel = new Label();
			_startedLabel.text = "Partie en cours";
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (_game) {
//					if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
//					}

					if (_game.isLocalClientAPlayer) {
						headerProperties.leftItems = new <DisplayObject>[_quitButton];
						if (!_game.started) {
							if (_game.isLocalClientTheOwner) {
								headerProperties.rightItems = new <DisplayObject>[_startButton];
							}
							else {
								headerProperties.rightItems = new <DisplayObject>[_holdLabel];
							}
						}
						else {
							headerProperties.rightItems = new <DisplayObject>[_resumeButton];
						}
					}
					else {
						headerProperties.leftItems = new <DisplayObject>[_backButton];
						if (_game.started) {
							headerProperties.rightItems = new <DisplayObject>[_startedLabel];
						}
						else {
							headerProperties.rightItems = new <DisplayObject>[_joinButton];
						}
					}
				}
			}
		}


		public function set game (value :GameVO) :void
		{
			if (value) {
				_game = value;

				_groupedListData.data = null;
				_groupedListData.data = [
					{
						header: "Joueurs :",
						children: Utils.vectorToArray(_game.players)
					},
					{
						header: "Catégories :",
						children: Utils.vectorToArray(_game.categories)
					}
				];

				invalidate(INVALIDATION_FLAG_DATA);
			}
		}


		private function onBackButton () :void
		{
			onLeave.dispatch();
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


		private function resumeButton_triggeredHandler (event :Event) :void
		{
			owner.showScreen(NavigatorView.GAME_MAIN);
		}


		private function quitButton_triggeredHandler (event :Event) :void
		{
			onQuit.dispatch();
		}
	}
}
