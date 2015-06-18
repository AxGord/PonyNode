package models;
import pony.db.DBV;
import pony.Errors;
import pony.net.http.modules.mmodels.fields.FDate;
import pony.net.http.modules.mmodels.fields.FString;
import pony.net.http.modules.mmodels.fields.FText;
import pony.net.http.modules.mmodels.Model;
import pony.net.http.modules.mmodels.ModelConnect;

/**
 * GuestBook
 * @author AxGord
 */
class GuestBook extends Model
{
	static var fields = {
		author: new FString(),
		text: new FText(),
		date: new FDate()
	};	
}

@:build(com.dongxiguo.continuation.Continuation.cpsByMeta(":async"))
class GuestBookConnect extends ModelConnect {
	
	@:async function many() return @await db.get();
	
	@:async function insert(author:String, text:String):Bool {
		return @await db.insert([
			'author' => (author:DBV),
			'text' => (text:DBV),
			'date' => (Std.int(Sys.time()):DBV)
		]);
	}
	
	function insertValidate(author:String, text:String):pony.Errors {
		var e = new pony.Errors();
		
		e.arg = 'text';
		e.test(text == '', 'Empty');
		e.test(text.length < 5, 'Is short');
		e.test(text.length > 500, 'Is long');
		
		e.arg = 'author';
		e.test(author.length > 32, 'Is long');
		
		return e;
	}
}