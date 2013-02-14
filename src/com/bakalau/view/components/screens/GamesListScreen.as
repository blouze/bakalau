/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 11:35
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import com.bakalau.model.vo.GameVO;
	import com.bakalau.view.components.data.GamesData;

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



	public class GamesListScreen extends PanelScreen
	{
		public var onJoinGame :Signal = new Signal(String);


		public function GamesListScreen ()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _list :List;
		private var _listData :ListCollection = new ListCollection(new Vector.<GameVO>());


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = "Parties disponibles";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			_list = new List();
			_list.dataProvider = _listData;
			_list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			_list.addEventListener(Event.CHANGE, onListChange);

			addChild(_list);

			if (true) {
//			if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
				_backButton = new Button();
				_backButton.label = "Back";
				_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				this.headerProperties.leftItems = new <DisplayObject>
						[
							this._backButton
						];
			}
			backButtonHandler = onBackButton;
		}


		private function onListChange (event :Event) :void
		{
			onJoinGame.dispatch(_list.selectedItem.value);
		}


		private function onBackButton () :void
		{
			dispatchEventWith(Event.COMPLETE);
		}


		private function backButton_triggeredHandler (event :Event) :void
		{
			onBackButton();
		}


		public function set gamesData (gamesData :GamesData) :void
		{
			_listData.data = null;
			_listData.data = gamesData.games;
		}
	}
}
