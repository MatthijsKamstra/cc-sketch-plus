package draw;

using StringTools;

class Base {
	public static var COUNT:Int = 0;

	public var count(get_count, null):Int;

	public var xml:Xml;

	@:isVar public var id(get, set):String;
	// position
	@:isVar public var y(get, set):Float;
	@:isVar public var x(get, set):Float;
	// colors
	@:isVar public var fill(get, set):String; // = '#909090';
	@:isVar public var stroke(get, set):String; // = '#000000';
	// weight
	@:isVar public var linewidth(get, set):Float; // = 1;
	@:isVar public var opacity(get, set):Float; // = 1;
	@:isVar public var strokeOpacity(get, set):Float;
	@:isVar public var fillOpacity(get, set):Float;

	// transform
	@:isVar public var rotate(get, set):Float;

	@:isVar public var transform(get, set):String;

	@:isVar public var dash(get, set):Array<Int>;

	@:isVar public var desc(get, set):String;

	@:isVar public var linecap(get, set):String;

	var transArr:Array<String> = [];

	public function new(name:String) {
		xml = Xml.createElement(name);
		COUNT++;
		id = get_id();
	}

	// ____________________________________ functions ____________________________________
	// public function noStroke() {
	// 	this.linewidth = 0;
	// 	this.stroke = 'transparant';
	// }

	public function setPosition(x:Float, ?y:Float) {
		var str = 'translate(${x}';
		if (y != null)
			str += ',${y}';
		str += ')';
		transArr.push(str);
	}

	public function setRotate(degree:Float, ?x:Float, ?y:Float) {
		var str = 'rotate(${degree}';
		if (x != null)
			str += ',${x}';
		if (y != null)
			str += ',${y}';
		str += ')';
		transArr.push(str);
	}

	public function setScale(x:Float, ?y:Float) {
		var str = 'scale(${x}';
		if (y != null)
			str += ',${y}';
		str += ')';
		transArr.push(str);
	}

	public function getTransform():String {
		var str = '';
		for (i in 0...transArr.length) {
			str += transArr[i] + ' ';
		}
		return str;
	}

	public function clone():Base {
		trace("WIP");
		return cast(haxe.Json.parse(haxe.Json.stringify(this)), Base);
	}

	// ____________________________________ getter/setter ____________________________________

	function get_id():String {
		if (id == null) {
			id = getName() + "_" + COUNT;
			COUNT++;
		}
		return id;
	}

	function set_id(value:String):String {
		// for import in Illustrator its easier to have id that contain no spaces
		value = value.toLowerCase().replace(" ", "_");
		if (xml != null) {
			xml.set('id', Std.string(value));
			xml.set('data-count', Std.string(COUNT));
		}
		return id = value;
	}

	function get_fill():String {
		return fill;
	}

	function set_fill(value:String):String {
		xml.set('fill', Std.string(value));
		return fill = value;
	}

	function get_stroke():String {
		return stroke;
	}

	function set_stroke(value:String):String {
		xml.set('stroke', Std.string(value));
		return stroke = value;
	}

	function get_linewidth():Float {
		return linewidth;
	}

	function set_linewidth(value:Float):Float {
		xml.set('stroke-width', Std.string(value));
		return linewidth = value;
	}

	function get_opacity():Float {
		return opacity;
	}

	function set_opacity(value:Float):Float {
		var v = cc.util.MathUtil.clamp(value, 0, 1); // should between 0 and 1
		xml.set('fill-opacity', Std.string(v));
		xml.set('stroke-opacity', Std.string(v));
		return opacity = v;
	}

	/**
	 * [Description]
	 * @return Float
	 */
	function get_strokeOpacity():Float {
		return strokeOpacity;
	}

	function set_strokeOpacity(value:Float):Float {
		var v = cc.util.MathUtil.clamp(value, 0, 1); // should between 0 and 1
		xml.set('stroke-opacity', Std.string(v));
		return strokeOpacity = v;
	}

	function get_fillOpacity():Float {
		return fillOpacity;
	}

	function set_fillOpacity(value:Float):Float {
		var v = cc.util.MathUtil.clamp(value, 0, 1); // should between 0 and 1
		xml.set('fill-opacity', Std.string(v));
		return fillOpacity = v;
	}

	function get_y():Float {
		return y;
	}

	function set_y(value:Float):Float {
		return y = value;
	}

	function get_x():Float {
		return x;
	}

	function set_x(value:Float):Float {
		return x = value;
	}

	function get_rotate():Float {
		return rotate;
	}

	function set_rotate(value:Float):Float {
		return rotate = value;
	}

	function get_transform():String {
		return transform;
	}

	function set_transform(value:String):String {
		return transform = value;
	}

	function get_dash():Array<Int> {
		return dash;
	}

	function set_dash(value:Array<Int>):Array<Int> {
		var str = '';
		for (i in 0...value.length) {
			str += value[i] + " ";
		}
		xml.set('stroke-dasharray', str);
		return dash = value;
	}

	function get_desc():String {
		return desc;
	}

	function set_desc(value:String):String {
		return desc = value;
	}

	function get_linecap():String {
		return linecap;
	}

	function set_linecap(value:String):String {
		xml.set('stroke-linecap', value);
		return linecap = value;
	}

	function get_count():Int {
		return COUNT;
	}

	// ____________________________________ toString ____________________________________

	public function getName() {
		var name = Type.getClassName(Type.getClass(this));
		return ('${name}');
	}

	public function toObject() {
		var name = Type.getClassName(Type.getClass(this));
		return haxe.Json.parse(haxe.Json.stringify(this));
	}

	public function toString() {
		var name = Type.getClassName(Type.getClass(this));
		return ('${name}: ' + haxe.Json.parse(haxe.Json.stringify(this)));
	}

	public function toSvg() {
		throw "Not implemented yet";
		// this.svg();
	}
}
