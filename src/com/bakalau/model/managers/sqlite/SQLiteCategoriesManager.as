/**
 * Created with IntelliJ IDEA.
 * User: Blouze
 * Date: 14/02/13
 * Time: 11:24
 * To change this template use File | Settings | File Templates.
 */
package com.bakalau.model.managers.sqlite
{
	import com.bakalau.model.VOs.CategoryVO;
	import com.bakalau.model.managers.ICategoriesManager;
	import com.probertson.data.SQLRunner;

	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;



	public class SQLiteCategoriesManager extends EventDispatcher implements ICategoriesManager
	{
		[Embed(source="sql/LoadCategories.sql", mimeType="application/octet-stream")]
		private static const LoadAllCategoriesStatementText :Class;
		private static const LOAD_ALL_CATEGORIES_SQL :String = new LoadAllCategoriesStatementText();

		private var _sqlRunner :SQLRunner;
		private var _result :Vector.<CategoryVO>;
		private var _error :SQLError;


		public function SQLiteCategoriesManager ()
		{
			var dbFile :File = File.userDirectory.resolvePath("Workspace/bakalau/db/bakalau.sqlite");
			_sqlRunner = new SQLRunner(dbFile);
		}


		public function loadCategories () :void
		{
			_sqlRunner.execute(LOAD_ALL_CATEGORIES_SQL, null, onResult, CategoryVO, onError);
		}


		private function onResult (result :SQLResult) :void
		{
			_result = Vector.<CategoryVO>(result.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}


		private function onError (error :SQLError) :void
		{
			_error = error;
			dispatchEvent(new Event(Event.COMPLETE));
		}


		public function get result () :Vector.<CategoryVO>
		{
			return _result;
		}


		public function get error () :SQLError
		{
			return _error;
		}
	}
}
