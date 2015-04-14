package;

import haxe.Log;
import haxe.PosInfos;
import pony.db.mysql.MySQL;
import pony.magic.Classes;
import pony.net.http.DefaultModulePack;
import pony.net.http.HttpServer;
import pony.net.http.modules.mmodels.DefaultActionsPack;
import pony.net.http.modules.mmodels.MModels;
import pony.net.http.WebServer;
import pony.Pair;

/**
 * Main
 * @author AxGord
 */

class Main 
{
	
	#if php
	static var trc:Array<Pair<Dynamic, PosInfos>> = [];
	#end
	
	static function main() 
	{
		#if (nodejs && debug)
		js.Node.require('source-map-support').install();
		#end
		#if php
		Log.trace = function(v:Dynamic, ?p:PosInfos) trc.push(new Pair(v, p));
		#end
		
		var db = new MySQL( { user: 'root', database: 'haxetestdb' } );
		db.log << Log.trace;
		db.error << Log.trace;
		
		var httpServer = new HttpServer(8088,{});
		var webServer:WebServer = new WebServer(['Home', 'Defaults'], DefaultModulePack.create().concat([
			cast new MModels(Classes.dir('', 'models'), DefaultActionsPack.list, db)
		]));
		httpServer.request = webServer.connect;
		
		#if php
		httpServer.run();
		php.Lib.print('<hr><pre>');
		for (p in trc) php.Lib.println(p.b.fileName+':' + p.b.lineNumber + ': ' + p.a);
		#end
		
	}
	
}