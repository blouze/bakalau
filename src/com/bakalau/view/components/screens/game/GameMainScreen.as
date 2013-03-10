/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 25/02/13
 * Time: 13:10
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.game
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.view.components.data.AnswersData;
	import com.bakalau.view.components.data.GameData;
	import com.bakalau.view.components.data.ListData;
	import com.bakalau.view.components.screens.game.renderers.AnswersListItemRenderer;
	import com.bakalau.view.components.screens.game.renderers.PlayersListItemRenderer;

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class GameMainScreen extends PanelScreen
	{
		public var onSelect :Signal = new Signal(List);
		public var onAnswer :Signal = new Signal(CategoryVO, String);
		public var onQuit :Signal = new Signal();
		public var onFinish :Signal = new Signal();


		public function GameMainScreen ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _answersList :List;
		private var _playersList :List;
		private var _quitButton :Button;
		private var _finishButton :Button;

		private var _answersListData :ListCollection = new ListCollection(new Vector.<ListData>());
		private var _playersListData :ListCollection = new ListCollection(new Vector.<ListData>());
		private var _gameID :String;
		private var _hasPlayerFinished :Boolean;


		protected function onInitialize (event :Event) :void
		{
			headerProperties.title = _gameID;
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			_quitButton = new Button();
			_quitButton.label = "Quitter";
			_quitButton.addEventListener(Event.TRIGGERED, quitButton_triggeredHandler);
			headerProperties.leftItems = new <DisplayObject>[_quitButton];

			_finishButton = new Button();
			_finishButton.label = "Terminé!";
			_finishButton.addEventListener(Event.TRIGGERED, finishButton_triggeredHandler);

			_answersList = new List();

			_answersList.itemRendererType = AnswersListItemRenderer;
			_answersList.itemRendererProperties.onSelect = onSelect;
			_answersList.itemRendererProperties.onAnswer = onAnswer;

			_answersList.dataProvider = _answersListData;

			_answersList.addEventListener(Event.CHANGE, onListChange);
			addChild(_answersList);


			_playersList = new List();
			_playersList.itemRendererType = PlayersListItemRenderer;
			_playersList.itemRendererProperties.progressMax = _answersListData.length;
			_playersList.dataProvider = _playersListData;
			_playersList.isSelectable = false;
			addChild(_playersList);
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				if (_hasPlayerFinished) {
					headerProperties.rightItems = new <DisplayObject>[_finishButton];
				}
				else {
					headerProperties.rightItems = null;
				}
			}
			if (isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE)) {
				_playersList.validate();
				var clientHeight :Number = Math.min((actualHeight - header.height) / 3);
				_playersList.layoutData = new AnchorLayoutData(actualHeight - header.height - clientHeight, 0, 0, 0);
				_answersList.layoutData = new AnchorLayoutData(0, 0, clientHeight + 8, 0);
			}
		}


		private function quitButton_triggeredHandler (event :Event) :void
		{
			onQuit.dispatch();
		}


		private function finishButton_triggeredHandler (event :Event) :void
		{
			onFinish.dispatch();
		}


		private function onListChange (event :Event) :void
		{
			onSelect.dispatch(_answersList);
		}


		public function set gameData (value :GameData) :void
		{
			if (value.game) {
				_gameID = value.game.gameID;

				invalidate(INVALIDATION_FLAG_DATA);
			}
		}


		public function set answersData (value :AnswersData) :void
		{
			if (value.localAnswers) {
				_answersListData.data = null;
				_answersListData.data = value.localAnswers;

				invalidate(INVALIDATION_FLAG_DATA);
			}

			if (value.progresses) {
				_playersListData.data = null;
				_playersListData.data = value.progresses;

				_hasPlayerFinished = value.hasPlayerFinished;

				invalidate(INVALIDATION_FLAG_DATA);
			}
		}
	}
}
