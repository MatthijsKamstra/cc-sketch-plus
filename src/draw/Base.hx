package draw;

class Base {
	public static var COUNT:Int = 0;

	@:isVar public var id(get, set):String;

	// ____________________________________ getter/setter ____________________________________

	function get_id():String {
		return id;
	}

	function set_id(value:String):String {
		return id = value;
	}

	// ____________________________________ toString ____________________________________

	public function getName() {
		var name = Type.getClassName(Type.getClass(this));
		return ('${name}');
	}

	public function toString() {
		var name = Type.getClassName(Type.getClass(this));
		return ('${name}: ' + haxe.Json.parse(haxe.Json.stringify(this)));
	}
}
