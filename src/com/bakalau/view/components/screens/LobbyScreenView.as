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
	import feathers.controls.ButtonGroup;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
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
		private var _startButton :Button;
		private var _resumeButton :Button;
		private var _quitButton :Button;
		private var _holdLabel :Label;
		private var _startedLabel :Label;

		private var _gameList :GroupedList;
		private var _joinButtonGroup :ButtonGroup;
		private var _gameListData :HierarchicalCollection = new HierarchicalCollection();
		private var _game :GameVO;


		private function onInitialize (event :Event) :void
		{
			layout = new AnchorLayout();

			_gameList = new GroupedList();
			_gameList.dataProvider = _gameListData;
			_gameList.itemRendererType = GameLobbyListItemRenderer;
			_gameList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			_gameList.isSelectable = false;
			_gameList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild(_gameList);

			_backButton = new Button();
			_backButton.label = "Retour".toUpperCase();
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			backButtonHandler = onBackButton;

			_startButton = new Button();
			_startButton.label = "Commencer".toUpperCase();
			_startButton.addEventListener(Event.TRIGGERED, startButton_triggeredHandler);

			_resumeButton = new Button();
			_resumeButton.label = "Reprendre".toUpperCase();
			_resumeButton.addEventListener(Event.TRIGGERED, resumeButton_triggeredHandler);

			_quitButton = new Button();
			_quitButton.label = "Quitter".toUpperCase();
			_quitButton.addEventListener(Event.TRIGGERED, quitButton_triggeredHandler);

			_holdLabel = new Label();
			_holdLabel.text = "En attente ...".toUpperCase();

			_startedLabel = new Label();
			_startedLabel.text = "Partie en cours";

			_joinButtonGroup = new ButtonGroup();
			_joinButtonGroup.dataProvider = new ListCollection(
					[
						{ label: "Rejoindre cette partie".toUpperCase(), triggered: joinButton_triggeredHandler }
					]);
			addChild(_joinButtonGroup);
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_SIZE)) {
				var buttonPadding :Number = actualHeight * (1 - 0.618) * (1 - 0.618) / 2;
				_joinButtonGroup.layoutData = new AnchorLayoutData(buttonPadding * 2, buttonPadding, actualHeight * 0.618, buttonPadding);
				_gameList.layoutData = new AnchorLayoutData(actualHeight * (1 - 0.618), 0, 0, 0);
			}

			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (_game) {
//					if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
//					}

					_startButton.isEnabled = (_game.players.length > 1);
					_joinButtonGroup.isEnabled = !_game.isLocalClientInPlayers;

					if (_game.isLocalClientInPlayers) {
						headerProperties.leftItems = new <DisplayObject>[_quitButton];
						if (!_game.started) {
							if (_game.isOwnedByLocalClient) {
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
							headerProperties.rightItems = new <DisplayObject>[];
						}
					}
				}
			}
		}


		public function set game (value :GameVO) :void
		{
			if (value) {
				_game = value;

				_gameListData.data = null;
				_gameListData.data = [
					{
						header: "Joueurs connectés :",
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
			if (_game.isLocalClientInPlayers) {
				onQuit.dispatch();
			}
			else {
				onLeave.dispatch();
			}
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
