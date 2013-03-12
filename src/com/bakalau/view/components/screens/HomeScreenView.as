/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 11/02/13
 * Time: 10:18
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import org.osflash.signals.Signal;

	import starling.events.Event;



	public class HomeScreenView extends PanelScreen
	{
		public var onListGames :Signal = new Signal();


		public function HomeScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _buttonGroup :ButtonGroup;


		protected function onInitialize (event :Event) :void
		{
			headerProperties.title = "BAKALAU!";
			headerProperties.titleAlign = Header.TITLE_ALIGN_CENTER;

			layout = new AnchorLayout();


			const buttonGroupLayoutData :AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;

			_buttonGroup = new ButtonGroup();
			_buttonGroup.dataProvider = new ListCollection(
					[
						{ label: "Jouer", triggered: onListGamesTriggered }
					]);
			_buttonGroup.layoutData = buttonGroupLayoutData;

			addChild(_buttonGroup);
		}


		private function onListGamesTriggered (event :Event) :void
		{
			onListGames.dispatch();
		}
	}
}
