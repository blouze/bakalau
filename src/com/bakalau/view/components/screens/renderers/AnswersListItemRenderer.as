/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 08/03/13
 * Time: 11:59
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.renderers
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;

	import flash.text.ReturnKeyLabel;

	import org.osflash.signals.Signal;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;



	public class AnswersListItemRenderer extends DefaultListItemRenderer
	{
		private var _backgroundSkin :DisplayObject;
		private var _answerUI :ScrollContainer;
		private var _textInput :TextInput;
		private var _confirmButton :Button;
		private var _cancelButton :Button;

		private var _selectSignal :Signal;
		private var _confirmSignal :Signal;


		override protected function initialize () :void
		{
			super.initialize();

			const answerlayout :HorizontalLayout = new HorizontalLayout();
			answerlayout.gap = 5;
			answerlayout.padding = 5;

			_answerUI = new ScrollContainer();
			_answerUI.layout = answerlayout;
			_answerUI.backgroundSkin = _backgroundSkin;

			_answerUI.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			_answerUI.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;

			_textInput = new TextInput();
			_textInput.textEditorProperties.returnKeyLabel = ReturnKeyLabel.GO;
			_textInput.addEventListener(FeathersEventType.ENTER, onUserTypeEnter);
			_answerUI.addChild(_textInput);

			_confirmButton = new Button();
			_confirmButton.label = "OK";
			_confirmButton.addEventListener(Event.TRIGGERED, onUserTypeEnter);
			_answerUI.addChild(_confirmButton);

			_cancelButton = new Button();
			_cancelButton.label = "X";
			_cancelButton.addEventListener(Event.TRIGGERED, cancelButton_triggered_handler);
			_answerUI.addChild(_cancelButton);


			labelField = "categoryName";

			accessoryFunction = function (item :Object) :DisplayObject
			{
				return _answerUI;
			};

			accessoryLabelField = "value";
			itemHasIcon = true;
			iconPosition = Button.ICON_POSITION_TOP;
		}


		override protected function draw () :void
		{
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE)) {
				_textInput.width = 0;
				validate();
				_textInput.width = actualWidth - labelTextRenderer.width - 160;
			}
		}


		private function onListChange (list :List) :void
		{
			if (list.selectedIndex == index) {
				accessoryLabelField = null;
				paddingRight = 0;
				if (_textInput) {
					_textInput.text = data ? data.value : "";
					_textInput.setFocus();
					_textInput.selectRange(0, _textInput.text.length - 1);
				}
			}
			else if (accessoryLabelField == null) {
				paddingRight = 20;
				accessoryLabelField = "value";
				invalidate(FeathersControl.INVALIDATION_FLAG_SELECTED);
			}
		}


		private function onUserTypeEnter (event :Event) :void
		{
			if (_textInput.text != data.value) {
				_confirmSignal.dispatch(data.category, _textInput.text);
			}
			Starling.current.nativeStage.focus = null;
			owner.selectedIndex = -1;
		}


		private function cancelButton_triggered_handler (event :Event) :void
		{
			owner.selectedIndex = -1;
		}


		public function set onSelect (value :Signal) :void
		{
			if (value) {
				_selectSignal = value;
				_selectSignal.add(onListChange);
			}
		}


		public function set onAnswer (value :Signal) :void
		{
			if (value) _confirmSignal = value;
		}


		public function set backgroundSkin (value :DisplayObject) :void
		{
			_backgroundSkin = value;
		}


		override public function dispose () :void
		{
			super.dispose();

			_cancelButton.removeEventListener(Event.TRIGGERED, cancelButton_triggered_handler);

			_confirmSignal = null;
			_selectSignal.remove(onListChange);
		}
	}
}
