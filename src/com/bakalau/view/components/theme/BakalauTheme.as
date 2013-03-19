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

	import feathers.display.TiledImage;
	import feathers.themes.AzureMobileTheme;

	import starling.display.DisplayObjectContainer;



	public class BakalauTheme extends AzureMobileTheme
	{


		public function BakalauTheme (root :DisplayObjectContainer, scaleToDPI :Boolean = true)
		{
			super(root, scaleToDPI);
		}


		override protected function initialize () :void
		{
			super.initialize();

			setInitializerForClass(GamesListItemRenderer, gamesListItemRendererInitializer);
			setInitializerForClass(AnswersListItemRenderer, answersListItemRendererInitializer);
			setInitializerForClass(PlayersListItemRenderer, playersListItemRendererInitializer);
			setInitializerForClass(GameLobbyListItemRenderer, gameLobbyListItemRendererInitializer);
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
