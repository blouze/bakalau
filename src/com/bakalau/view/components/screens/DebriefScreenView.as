/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 15/03/13
 * Time: 10:30
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.view.components.screens
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameVO;
	import com.bakalau.view.components.screens.renderers.DebriefListItemRenderer;

	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.data.HierarchicalCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;



	public class DebriefScreenView extends PanelScreen
	{
		public function DebriefScreenView ()
		{
			addEventListener(FeathersEventType.INITIALIZE, onInitialize);
		}


		private var _game :GameVO;

		private var _debriefListData :HierarchicalCollection = new HierarchicalCollection();

		private var _debrief :Array;


		private function onInitialize (event :Event) :void
		{
			headerProperties.title = _game ? _game.gameID : "";
			headerProperties.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

			layout = new AnchorLayout();

			var answersList :GroupedList = new GroupedList();
			answersList.dataProvider = _debriefListData;
			answersList.itemRendererType = DebriefListItemRenderer;
			answersList.nameList.add(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);
			answersList.isSelectable = false;
			answersList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild(answersList);
		}


		override protected function draw () :void
		{
			super.draw();
		}


		public function set game (value :GameVO) :void
		{
			if (value) {
				_game = value;

				setDebrief();

				_debriefListData.data = null;
				_debriefListData.data = _debrief;

				invalidate(INVALIDATION_FLAG_DATA);
			}
		}


		private function setDebrief () :void
		{
			_debrief = [];
			for each (var category :CategoryVO in _game.categories) {
				_debrief.push({
					header: category.name + ":",
					children: []
				});
			}
		}
	}
}
