/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 31/01/13
 * Time: 11:56
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau
{
	import com.bakalau.model.VOs.AnswerVO;
	import com.bakalau.model.VOs.AppMessageVO;
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.VOs.GameMessageVO;
	import com.bakalau.model.VOs.GameVO;

	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;

	import mx.utils.RpcClassAliasInitializer;

	import starling.core.Starling;
	import starling.events.ResizeEvent;



	public class Bakalau extends Sprite
	{
		private var _starling :Starling;


		public function Bakalau ()
		{
			trace("[Bakalau]");

			registerClassAlias("com.bakalau.model.VOs.AppMessageVO", AppMessageVO);
			registerClassAlias("com.bakalau.model.VOs.GameMessageVO", GameMessageVO);
			registerClassAlias("com.bakalau.model.VOs.CategoryVO", CategoryVO);
			registerClassAlias("com.bakalau.model.VOs.GameVO", GameVO);
			registerClassAlias("com.bakalau.model.VOs.AnswerVO", AnswerVO);
			RpcClassAliasInitializer.registerClassAliases();

			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		private function onAddedToStage (event :Event) :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			Starling.handleLostContext = true;

			_starling = new Starling(BakalauStarling, stage);
			_starling.showStats = true;
			_starling.stage.addEventListener(Event.RESIZE, onResize);
			_starling.start();
		}


		private function onResize (event :ResizeEvent) :void
		{
			var scale :Number = Starling.current.contentScaleFactor;
			var viewPort :Rectangle = new Rectangle(0, 0, event.width, event.height);

			Starling.current.viewPort = viewPort;
			_starling.stage.stageWidth = viewPort.width / scale;
			_starling.stage.stageHeight = viewPort.height / scale;
		}
	}
}
