/**
 * https://two.js.org/#documentation
 */
class Settings {
	@:isVar public var type(get, set):String = 'svg';

	@:isVar public var width(get, set):Int; // CANVAS width in pixels - SVG width (in pixels or mm, depending on sizeType is set)
	@:isVar public var height(get, set):Int;

	@:isVar public var padding(get, set):Int = 0;
	@:isVar public var margin(get, set):Int = 0;

	@:isVar public var isScaled(get, set):Bool = false;
	@:isVar public var isAutostart(get, set):Bool = false; // don't think this does anything (yet)
	@:isVar public var isAnimation(get, set):Bool = true;

	#if js
	@:isVar public var element(get, set):js.html.Element;
	@:isVar public var elementID(get, set):String;
	#end

	// SVG ONLY
	@:isVar public var viewBox(get, set):Array<Float>; // always in pixels
	@:isVar public var sizeType(get, set):SizeType; // ???? 'mm' vs 'px' // perhaps only for svg

	/**
	 * Settings use for sketcher
	 *
	 * @example
	 * 			var settings = new Settings(210, 297, 'svg');
	 *			settings.isAutostart = false; // (default is false)
	 *			settings.isAnimation = false; // default is true (based upon canvas)
	 *			settings.padding = 10;
	 *			settings.isScaled = false; // (default is false)
	 *			settings.sizeType = 'mm';
	 *			settings.elementID = 'sketcher-svg-wrapper';
	 *
	 * @param width		stage/canvas/sketch width in pixels
	 * @param height	stage/canvas/sketch height in pixels
	 * @param type		(default svg) type of sketches base; 'svg', 'canvas' will work or use SketchTyper.CANVAS, SketchTyper.SVG
	 */
	public function new(width:Int, height:Int, ?type:String = 'svg') {
		this.width = width;
		this.height = height;
		this.type = type.toLowerCase(); // make sure to use lowercase
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

	function get_isScaled():Bool {
		return isScaled;
	}

	function set_isScaled(value:Bool):Bool {
		return isScaled = value;
	}

	#if js
	function get_element():js.html.Element {
		return element;
	}

	function set_element(value:js.html.Element):js.html.Element {
		return element = value;
	}
	#end

	#if js
	function get_elementID():String {
		return elementID;
	}

	function set_elementID(value:String):String {
		return elementID = value;
	}
	#end

	function get_margin():Int {
		return margin;
	}

	function set_margin(value:Int):Int {
		return margin = value;
	}

	function get_isAutostart():Bool {
		return isAutostart;
	}

	function set_isAutostart(value:Bool):Bool {
		return isAutostart = value;
	}

	function get_sizeType():SizeType {
		return sizeType;
	}

	function set_sizeType(value:SizeType):SizeType {
		return sizeType = value;
	}

	function get_isAnimation():Bool {
		return isAnimation;
	}

	function set_isAnimation(value:Bool):Bool {
		return isAnimation = value;
	}

	function get_viewBox():Array<Float> {
		return viewBox;
	}

	function set_viewBox(value:Array<Float>):Array<Float> {
		if (value.length != 4) {
			#if js
			js.Browser.console.warn('Expect 4 float values: "0 0 300 400"');
			#else
			trace('Expect 4 float values: "0 0 300 400"');
			#end
		}
		return viewBox = value;
	}
}

enum abstract SketchTyper(String) from String to String {
	var SVG = 'svg';
	var CANVAS = 'canvas';
	var WEBGL = 'webgl';
}

enum abstract SizeType(String) from String to String {
	var PX = 'px';
	var MM = 'mm';
	var CM = 'cm';
}
