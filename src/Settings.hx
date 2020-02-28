/**
 * https://two.js.org/#documentation
 */
class Settings {
	@:isVar public var type(get, set):String = 'svg';
	@:isVar public var width(get, set):Int;
	@:isVar public var height(get, set):Int;

	@:isVar public var padding(get, set):Int;
	@:isVar public var margin(get, set):Int;

	@:isVar public var scale(get, set):Bool;
	@:isVar public var autostart(get, set):Bool;

	@:isVar public var element(get, set):js.html.Element;
	@:isVar public var elementID(get, set):String;

	@:isVar public var sizeType(get, set):String;

	public function new(width:Int, height:Int, ?type:String = 'svg') {
		this.width = width;
		this.height = height;
		this.type = type.toLowerCase(); // make sure to user lowercase
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

	function get_padding():Int {
		return padding;
	}

	function set_padding(value:Int):Int {
		return padding = value;
	}

	function get_scale():Bool {
		return scale;
	}

	function set_scale(value:Bool):Bool {
		return scale = value;
	}

	function get_element():js.html.Element {
		return element;
	}

	function set_element(value:js.html.Element):js.html.Element {
		return element = value;
	}

	function get_margin():Int {
		return margin;
	}

	function set_margin(value:Int):Int {
		return margin = value;
	}

	function get_autostart():Bool {
		return autostart;
	}

	function set_autostart(value:Bool):Bool {
		return autostart = value;
	}

	function get_elementID():String {
		return elementID;
	}

	function set_elementID(value:String):String {
		return elementID = value;
	}

	function get_sizeType():String {
		return sizeType;
	}

	function set_sizeType(value:String):String {
		return sizeType = value;
	}
}

enum abstract SketchType(String) from String to String {
	var SVG = 'svg';
	var CANVAS = 'canvas';
	var WEBGL = 'webgl';
}
