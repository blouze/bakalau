/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 25/02/13
 * Time: 13:10
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.renderers.AnswersListItemRenderer;
	import com.bakalau.view.components.screens.renderers.PlayersListItemRenderer;
	import com.projectcocoon.p2p.vo.ClientVO;

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.utils.Dictionary;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class GameScreenView extends PanelScreen
	{
		public var onSelect :Signal = new Signal(List);
		public var onAnswer :Signal = new Signal(CategoryVO, String);
		public var onFinish :Signal = new Signal();


		public function GameScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _answersList :List;
		private var _playersList :List;
		private var _finishButton :Button;

		private var _answersListData :ListCollection = new ListCollection(new Vector.<AnswerVO>());
		private var _playersListData :ListCollection = new ListCollection(new Vector.<ClientVO>());

		private var _game :GameVO;
		private var _answers :Dictionary;
		private var _progresses :Array;
		private var _localPlayerProgress :int;
		private var _localPlayerHasFinished :Boolean = false;


		protected function onInitialize (event :Event) :void
		{
			layout = new AnchorLayout();

			var _backButton :Button = new Button();
			_backButton.label = "Retour".toUpperCase();
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			headerProperties.leftItems = new <DisplayObject>[_backButton];

			backButtonHandler = onBackButton;

			_finishButton = new Button();
			_finishButton.label = "J'ai fini!".toUpperCase();
			_finishButton.addEventListener(Event.TRIGGERED, finishButton_triggeredHandler);
			headerProperties.rightItems = new <DisplayObject>[_finishButton];

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
				if (_localPlayerHasFinished) {
					headerProperties.rightItems = new <DisplayObject>[];
					if (_localPlayerProgress < _answersListData.length) {
						headerProperties.title = "J'ai fini.";
						headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_RIGHT;
					}
				}
			}

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE)) {
				_playersList.validate();
				var clientHeight :Number = Math.min((actualHeight - header.height) * (1 - 0.618));
				_playersList.layoutData = new AnchorLayoutData(actualHeight - header.height - clientHeight, 0, 0, 0);
				_answersList.layoutData = new AnchorLayoutData(0, 0, clientHeight + 8, 0);
			}
		}


		public function set game (value :GameVO) :void
		{
			_game = value;

			if (value) {
				invalidate(INVALIDATION_FLAG_DATA);
			}
		}


		public function set answers (value :Dictionary) :void
		{
			if (value) {
				_answers = value;

				_answersListData.data = null;
				_answersListData.data = _answers[_game.localClient.groupID];
			}
		}


		public function set progresses (value :Dictionary) :void
		{
			if (value) {
				_progresses = [];

				for (var playerGroupID :String in value) {
					var answers :Vector.<AnswerVO> = Vector.<AnswerVO>(_answers[playerGroupID]);
					var player :ClientVO = answers[0].player;

					_progresses.push({
						label: player.clientName,
						value: value[playerGroupID]
					});

					if (player == _game.localClient) {
						_localPlayerProgress = value[playerGroupID];
					}
				}

				_progresses.sortOn("value", Array.NUMERIC);
				_progresses.reverse();

				_playersListData.data = null;
				_playersListData.data = _progresses;

				invalidate(INVALIDATION_FLAG_DATA);
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


		private function finishButton_triggeredHandler (event :Event) :void
		{
			_localPlayerHasFinished = true;
			_answersList.isEnabled = false;

			onFinish.dispatch();

			invalidate(INVALIDATION_FLAG_DATA);
		}


		private function onListChange (event :Event) :void
		{
			onSelect.dispatch(_answersList);
		}
	}
}
