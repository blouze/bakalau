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
	import feathers.layout.VerticalLayout;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.events.Event;



	public class CreateGameScreen extends PanelScreen
	{
		public var onConfirm :Signal = new Signal();


		public function CreateGameScreen ()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _backButton :Button;
		private var _confirmButton :Button;
		private var _categories :Vector.<CategoryVO>;
		private var _checkContainer :ScrollContainer;


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = "Nouvelle partie";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			const verticalLayout :VerticalLayout = new VerticalLayout();
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.padding = 22 * dpiScale;
			verticalLayout.paddingLeft = verticalLayout.paddingRight *= 2;
			verticalLayout.gap = 44 * dpiScale;
			layout = verticalLayout;

			_checkContainer = new ScrollContainer();
			_checkContainer.layout = verticalLayout;
			_checkContainer.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_checkContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			addChild(this._checkContainer);

			for each (var categoryVO :CategoryVO in _categories) {
				var _check :Check = new Check();
				_check.isSelected = false;
				var categoryName :String = String(String(categoryVO.name).substr(0, 1)).toUpperCase() + String(categoryVO.name).slice(1);
				_check.label = categoryName;
				_checkContainer.addChild(_check);
			}

			if (true) {
//			if (!DeviceCapabilities.isTablet(Starling.current.nativeStage)) {
				_backButton = new Button();
				_backButton.label = "Retour";
				_backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

				this.headerProperties.leftItems = new <DisplayObject>
						[
							this._backButton
						];

				_confirmButton = new Button();
				_confirmButton.label = "OK";
				_confirmButton.addEventListener(Event.TRIGGERED, confirmButton_triggeredHandler);

				this.headerProperties.rightItems = new <DisplayObject>
						[
							this._confirmButton
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


		private function confirmButton_triggeredHandler (event :Event) :void
		{
			onConfirm.dispatch();
		}


		public function set gamesData (gamesData :GamesData) :void
		{
			_categories = gamesData.categories;
		}
	}
}
