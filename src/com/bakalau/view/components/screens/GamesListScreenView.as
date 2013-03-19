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
	import com.bakalau.view.components.screens.renderers.GamesListItemRenderer;

	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.GroupedList;
	import feathers.controls.PanelScreen;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class GamesListScreenView extends PanelScreen
	{
		public var onSelect :Signal = new Signal(String);
		public var onCreate :Signal = new Signal();


		public function GamesListScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _buttonGroup :ButtonGroup;
		private var _gamesList :GroupedList;
		private var _listData :HierarchicalCollection = new HierarchicalCollection();


		private function onInitialize (event :Event) :void
		{
			layout = new AnchorLayout();


			var _backButton :Button = new Button();
			_backButton.label = "Retour";
			_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			headerProperties.leftItems = new <DisplayObject>
					[
						_backButton
					];


			_buttonGroup = new ButtonGroup();
			_buttonGroup.gap = 36;
			_buttonGroup.dataProvider = new ListCollection(
					[
						{ label: "Créer une partie", triggered: createGameButton_triggeredHandler }
					]);
			addChild(_buttonGroup);


			_gamesList = new GroupedList();
			_gamesList.dataProvider = _listData;
			_gamesList.itemRendererType = GamesListItemRenderer;
			_gamesList.hasElasticEdges = false;
			_gamesList.addEventListener(Event.CHANGE, onListChange);
			addChild(_gamesList);


			backButtonHandler = onBackButton;
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_SIZE)) {
				var buttonPadding :Number = actualHeight * (1 - 0.618) * (1 - 0.618);
				_buttonGroup.layoutData = new AnchorLayoutData(buttonPadding, buttonPadding, actualHeight * (1 - 0.618) + buttonPadding, buttonPadding);
				_gamesList.layoutData = new AnchorLayoutData(actualHeight * 0.618, 0, 0, 0);
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


		private function createGameButton_triggeredHandler (event :Event) :void
		{
			onCreate.dispatch();
		}


		private function onListChange (event :Event) :void
		{
			onSelect.dispatch(_gamesList.selectedItem.gameID);
		}


		public function set games (value :Vector.<GameVO>) :void
		{
			_listData.data = null;

			var headerText :String;
			if (value.length >= 2) {
				headerText = value.length + " parties disponibles :"
			}
			else if (value.length > 0) {
				headerText = value.length + " partie disponible :"
			}
			else {
				headerText = "Aucune partie disponible"
			}

			_listData.data = [
				{
					header: headerText,
					children: Utils.vectorToArray(value)
				}
			];
		}
	}
}
