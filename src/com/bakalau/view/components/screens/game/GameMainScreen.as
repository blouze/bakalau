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

	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.controls.popups.IPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;

	import org.osflash.signals.Signal;

	import starling.events.Event;



	public class GameMainScreen extends PanelScreen
	{
		public var onAnswer :Signal = new Signal(CategoryVO, String);


		public function GameMainScreen ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _list :List;

		private var _popupContentManager :IPopUpContentManager;
		private var _answerContainer :ScrollContainer;
		private var _textInput :TextInput;

		private var _listData :ListCollection = new ListCollection(new Vector.<ListData>());
		private var _gameID :String;


		protected function onInitialize (event :Event) :void
		{
			headerProperties.title = _gameID;
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();


			_list = new List();
			_list.dataProvider = _listData;
			_list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			_list.itemRendererProperties.labelField = "categoryName";
			_list.itemRendererProperties.accessoryLabelField = "value";
			_list.addEventListener(Event.CHANGE, onListChange);
			addChild(_list);

			_popupContentManager = new VerticalCenteredPopUpContentManager();


			const answerlayout :VerticalLayout = new VerticalLayout();

			_answerContainer = new ScrollContainer();
			_answerContainer.layout = answerlayout;
			_answerContainer.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_answerContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;

			_textInput = new TextInput();
			_answerContainer.addChild(_textInput);

			const buttonGroupLayoutData :AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;

			var buttonGroup :ButtonGroup = new ButtonGroup();
			buttonGroup.dataProvider = new ListCollection(
					[
						{ label: "Valider", triggered: onConfirmAnswer }
					]);
			buttonGroup.layoutData = buttonGroupLayoutData;
			_answerContainer.addChild(buttonGroup);
		}


		private function onListChange (event :Event) :void
		{
			if (_list.selectedIndex >= 0) {
				_popupContentManager.open(_answerContainer, this);
				_answerContainer.validate();
			}
		}


		private function onConfirmAnswer (event :Event) :void
		{
			if (_textInput.text != "") {
				onAnswer.dispatch(_list.selectedItem.category, _textInput.text);
			}

			_list.selectedIndex = -1;
			_popupContentManager.close();
		}


		public function set gameData (value :GameData) :void
		{
			if (value.game) {
				_gameID = value.game.gameID;
			}
		}


		public function set answersData (value :AnswersData) :void
		{
			_listData.data = null;
			_listData.data = value.localAnswers;

			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
