/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 09/03/13
 * Time: 22:51
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens.renderers
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.projectcocoon.p2p.vo.ClientVO;

	import feathers.controls.renderers.DefaultGroupedListItemRenderer;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;



	public class GameLobbyListItemRenderer extends DefaultGroupedListItemRenderer
	{
		override protected function initialize () :void
		{
			super.initialize();

			labelFunction = gameLobbyListItemLabel;
		}


		private function gameLobbyListItemLabel (item :Object) :String
		{
			var itemClass :Class = Class(getDefinitionByName(getQualifiedClassName(item)));
			if (itemClass == ClientVO) {
				return ClientVO(item).clientName;
			}
			else if (itemClass == CategoryVO) {
				return CategoryVO(item).name;
			}

			return labelField;
		}


		override protected function draw () :void
		{
			super.draw();
		}
	}
}
