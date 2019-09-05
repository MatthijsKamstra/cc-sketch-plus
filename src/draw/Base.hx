package draw;

class Base {
	public static var COUNT:Int = 0;

	public var xml:Xml;

	@:isVar public var id(get, set):String;
	// position
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;
	// colors
	@:isVar public var fill(get, set):String; // = '#909090';
	@:isVar public var stroke(get, set):String; // = '#000000';
	// weight
	@:isVar public var linewidth(get, set):Int; // = 1;
	@:isVar public var opacity(get, set):Float; // = 1;
	// transform
	@:isVar public var rotate(get, set):Int;

	@:isVar public var transform(get, set):String;

	@:isVar public var dash(get, set):Array<Int>;

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

	public function setRotate(degree:Int, ?x:Float, ?y:Float) {
		var str = 'rotate(${degree}';
		if (x != null)
			str += ',${x}';
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
		if (xml != null)
			xml.set('id', Std.string(value));
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

	function get_linewidth():Int {
		return linewidth;
	}

	function set_linewidth(value:Int):Int {
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

	function get_y():Int {
		return y;
	}

	function set_y(value:Int):Int {
		return y = value;
	}

	function get_x():Int {
		return x;
	}

	function set_x(value:Int):Int {
		return x = value;
	}

	function get_rotate():Int {
		return rotate;
	}

	function set_rotate(value:Int):Int {
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
}
