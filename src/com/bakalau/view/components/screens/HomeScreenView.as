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
	import feathers.controls.ScrollText;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;

	import org.osflash.signals.Signal;

	import starling.events.Event;



	public class HomeScreenView extends PanelScreen
	{
		public var onListGames :Signal = new Signal();

		private var _buttonGroup :ButtonGroup;


		public function HomeScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		protected function onInitialize (event :Event) :void
		{
			headerProperties.title = "BaKaLau!";
			headerProperties.titleAlign = Header.TITLE_ALIGN_CENTER;

			var verticalLayout :VerticalLayout = new VerticalLayout();
			verticalLayout.gap = 36;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			layout = verticalLayout;

			var _scrollText :ScrollText = new ScrollText();
			_scrollText.text = "Le jeu du baccalauréat, le seul, le vrai! \n\n" +
					"De 2 à 8 joueurs par partie. \n\n" +
					"Pour jouer avec vos amis, c'est facile: \n" +
					"il suffit d'être connecté au réseau Wi-Fi après avoir installé l'application, " +
					"puis de créer une partie, ou de rejoindre une partie existante. \n\n" +
					"Répondez dans le plus grand nombre de catégories et cliquez sur \"J'ai fini!\". \n\n" +
					"Les réponses uniques comptent double.\n" +
					"Le joueur qui répond le premier dans toutes les catégories clôt la manche.";
			addChild(_scrollText);

			const buttonGroupLayoutData :AnchorLayoutData = new AnchorLayoutData();
			buttonGroupLayoutData.horizontalCenter = 0;
			buttonGroupLayoutData.verticalCenter = 0;

			_buttonGroup = new ButtonGroup();
			_buttonGroup.dataProvider = new ListCollection(
					[
						{ label: "Commencer".toUpperCase(), triggered: onListGamesTriggered }
					]);
			_buttonGroup.layoutData = buttonGroupLayoutData;

			addChild(_buttonGroup);


			backButtonHandler = onBackButton;
		}


		private function onBackButton () :void
		{
			dispatchEventWith(Event.COMPLETE);
		}


		private function onListGamesTriggered (event :Event) :void
		{
			onListGames.dispatch();
		}
	}
}
