/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 12:58
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.view.components.data.GamesData;

	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.TiledRowsLayout;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class CreateGameScreen extends PanelScreen
	{
		public var onConfirm :Signal = new Signal();


		public function CreateGameScreen ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _confirmButton :Button;
		private var _categories :Vector.<CategoryVO>;
		private var _container :ScrollContainer;


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = "Nouvelle partie";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			const layout :TiledRowsLayout = new TiledRowsLayout();
			layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_MIDDLE;
			layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
			layout.padding = 22 * dpiScale;
			layout.paddingLeft = layout.paddingRight *= 2;
			layout.gap = 44 * dpiScale;
			layout.useSquareTiles = false;

			_container = new ScrollContainer();
			_container.layout = layout;
			_container.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			addChild(_container);

			for each (var categoryVO :CategoryVO in _categories) {
				var check :Check = new Check();
				check.isSelected = false;
				var categoryName :String = String(String(categoryVO.name).substr(0, 1)).toUpperCase() + String(categoryVO.name).slice(1);
				check.label = categoryName;
				_container.addChild(check);
			}

			if (true) {
//			if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
				_backButton = new Button();
				_backButton.label = "Retour";
				_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				headerProperties.leftItems = new <DisplayObject>
						[
							this._backButton
						];

				_confirmButton = new Button();
				_confirmButton.label = "OK";
				_confirmButton.addEventListener(Event.TRIGGERED, confirmButton_triggeredHandler);

				headerProperties.rightItems = new <DisplayObject>
						[
							this._confirmButton
						];
			}
			backButtonHandler = onBackButton;
		}


		override protected function draw () :void
		{
			super.draw();

			_container.width = actualWidth;
			_container.height = actualHeight - header.height;
		}


		private function onBackButton () :void
		{
			dispatchEventWith(Event.COMPLETE);
		}


		private function backButton_triggeredHandler (event :Event) :void
		{
			onBackButton();
		}


		private function confirmButton_triggeredHandler (event :Event) :void
		{
			onConfirm.dispatch();
		}


		public function set gamesData (gamesData :GamesData) :void
		{
			_categories = gamesData.categories;
			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
