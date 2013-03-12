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

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class ListScreenView extends PanelScreen
	{
		public var onSelect :Signal = new Signal(String);
		public var onCreate :Signal = new Signal();


		public function ListScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _list :List;
		private var _listData :ListCollection = new ListCollection(new Vector.<GameVO>());


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = "Parties disponibles";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			_list = new List();
			_list.dataProvider = _listData;
			_list.itemRendererProperties.labelField = "gameID";
			_list.itemRendererProperties.value = "gameID";
			_list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			_list.addEventListener(Event.CHANGE, onListChange);
			addChild(_list);

			if (true) {
//			if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
				var _backButton :Button = new Button();
				_backButton.label = "Retour";
				_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				headerProperties.leftItems = new <DisplayObject>
						[
							_backButton
						];

				var _createGameButton :Button = new Button();
				_createGameButton.label = "Nouvelle";
				_createGameButton.addEventListener(Event.TRIGGERED, createGameButton_triggeredHandler);

				headerProperties.rightItems = new <DisplayObject>
						[
							_createGameButton
						];
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


		private function createGameButton_triggeredHandler (event :Event) :void
		{
			onCreate.dispatch();
		}


		private function onListChange (event :Event) :void
		{
			onSelect.dispatch(_list.selectedItem.gameID);
		}


		public function set games (value :Vector.<GameVO>) :void
		{
			_listData.data = null;
			_listData.data = value;
		}
	}
}
