/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 08/03/13
 * Time: 12:20
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.theme
{
	import com.bakalau.view.components.screens.renderers.AnswersListItemRenderer;
	import com.bakalau.view.components.screens.renderers.GameLobbyListItemRenderer;
	import com.bakalau.view.components.screens.renderers.GamesListItemRenderer;
	import com.bakalau.view.components.screens.renderers.PlayersListItemRenderer;

	import feathers.controls.Check;
	import feathers.controls.GroupedList;
	import feathers.controls.List;
	import feathers.controls.ScrollText;
	import feathers.display.TiledImage;
	import feathers.text.BitmapFontTextFormat;
	import feathers.themes.AzureMobileTheme;

	import flash.text.TextFormat;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;



	public class BakalauTheme extends AzureMobileTheme
	{
		public static var BACKGROUND_COLOR :uint = 0xFFFFFF;
		public static var PRIMARY_TEXT_COLOR :uint = 0x2E2E2E;
		public static var SELECTED_TEXT_COLOR :uint = PRIMARY_TEXT_COLOR;
		public static var LIST_BACKGROUND_COLOR :uint = 0xC0C0C0;


		public function BakalauTheme (root :DisplayObjectContainer, scaleToDPI :Boolean = true)
		{
			super(root, scaleToDPI);
			Starling.current.nativeStage.color = BACKGROUND_COLOR;
			if (root.stage) {
				root.stage.color = BACKGROUND_COLOR;
			}
		}


		override protected function initialize () :void
		{
			super.initialize();

			setInitializerForClass(GamesListItemRenderer, gamesListItemRendererInitializer);
			setInitializerForClass(AnswersListItemRenderer, answersListItemRendererInitializer);
			setInitializerForClass(PlayersListItemRenderer, playersListItemRendererInitializer);
			setInitializerForClass(GameLobbyListItemRenderer, gameLobbyListItemRendererInitializer);
		}


		override protected function scrollTextInitializer (text :ScrollText) :void
		{
			super.scrollTextInitializer(text);
			text.textFormat = new TextFormat("Lato,Roboto,Helvetica,Arial,_sans", this.fontSize, PRIMARY_TEXT_COLOR);
		}


		override protected function checkInitializer (check :Check) :void
		{
			super.checkInitializer(check);
			check.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);
			check.defaultSelectedLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, SELECTED_TEXT_COLOR);
		}


		override protected function listInitializer (list :List) :void
		{
			list.backgroundSkin = new Quad(100, 100, LIST_BACKGROUND_COLOR);
		}


		override protected function groupedListInitializer (list :GroupedList) :void
		{
			list.backgroundSkin = new Quad(100, 100, LIST_BACKGROUND_COLOR);
		}


		private function gamesListItemRendererInitializer (renderer :GamesListItemRenderer) :void
		{
			itemRendererInitializer(renderer);
		}


		private function answersListItemRendererInitializer (renderer :AnswersListItemRenderer) :void
		{
			itemRendererInitializer(renderer);

			var backgroundSkin :TiledImage = new TiledImage(toolBarBackgroundSkinTexture);
			backgroundSkin.setSize(6, 6);
			renderer.backgroundSkin = backgroundSkin;
		}


		private function playersListItemRendererInitializer (renderer :PlayersListItemRenderer) :void
		{
			itemRendererInitializer(renderer);
		}


		private function gameLobbyListItemRendererInitializer (renderer :GameLobbyListItemRenderer) :void
		{
			itemRendererInitializer(renderer);
		}
	}
}
