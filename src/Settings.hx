/**
 * https://two.js.org/#documentation
 */
class Settings {
	@:isVar public var width(get, set):Int;
	@:isVar public var type(get, set):String = 'svg';
	@:isVar public var height(get, set):Int;

	public function new(width:Int, height:Int, ?type:String = 'svg') {
		this.width = width;
		this.height = height;
		this.type = type;
	}

	// ____________________________________ getter/setter ____________________________________
	function get_width():Int {
		return width;
	}

	function set_width(value:Int):Int {
		return width = value;
	}

	function get_height():Int {
		return height;
	}

	function set_height(value:Int):Int {
		return height = value;
	}

	function get_type():String {
		return type;
	}

	function set_type(value:String):String {
		return type = value;
	}
}
