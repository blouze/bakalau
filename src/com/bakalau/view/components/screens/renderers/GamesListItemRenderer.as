/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/03/13
 * Time: 22:51
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.renderers
{
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.skins.StandardIcons;

	import starling.textures.Texture;



	public class GamesListItemRenderer extends DefaultGroupedListItemRenderer
	{
		override protected function initialize () :void
		{
			super.initialize();

			labelField = "gameID";
			accessorySourceFunction = function (item :Object) :Texture
			{
				return StandardIcons.listDrillDownAccessoryTexture;
			};
		}


		override protected function draw () :void
		{
			super.draw();
		}
	}
}
