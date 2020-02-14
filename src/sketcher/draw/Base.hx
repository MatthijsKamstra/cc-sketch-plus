package sketcher.draw;

import sketcher.draw.AST.LineCap;
import sketcher.draw.AST.LineJoin;
import sketcher.AST;
import sketcher.util.MathUtil;

using StringTools;

class Base {
	public static var COUNT:Int = 0;

	public var count(get, null):Int;

	public var xml:Xml;

	@:isVar public var id(get, set):String;

	// Positions the shape horizontally from the origin.
	@:isVar public var x(get, set):Float;
	// Positions the shape vertically from the origin.
	@:isVar public var y(get, set):Float;

	// colors

	/**
	 * fill is the fill color
	 */
	@:isVar public var fill(get, set):String; // = '#909090';

	@:isVar public var fillColor(get, set):String;

	/**
	 * use a gradient as color
	 * is syntatic sugar for
	 * 			bg1.fillColor = 'url(#yoda-gradient)'; // works
	 *			bg1.fillGradientColor = 'yoda-gradient'; // better?
	 */
	@:isVar public var fillGradientColor(get, set):String;

	/**
	 * stroke is the stroke color
	 */
	@:isVar public var stroke(get, set):String; // = '#000000';

	@:isVar public var strokeColor(get, set):String;

	// weight
	@:isVar public var lineWeight(get, set):Float; // = 1;
	// strokeWeight
	@:isVar public var strokeWeight(get, set):Float;

	@:isVar public var opacity(get, set):Float; // = 1;
	@:isVar public var strokeOpacity(get, set):Float;
	@:isVar public var fillOpacity(get, set):Float;

	/**
	 * probably only usefull for groups (hide everything in this group)
	 */
	@:isVar public var isVisible(get, set):Bool;

	// transform
	@:isVar public var rotate(get, set):Float;
	@:isVar public var move(get, set):Point; // move x/y

	@:isVar public var transform(get, set):String;

	// dashed line
	@:isVar public var dash(get, set):Array<Float> = [];

	@:isVar public var desc(get, set):String;

	// line specific
	@:isVar public var lineCap(get, set):LineCap; // "butt|round|square";
	@:isVar public var lineJoin(get, set):LineJoin; // "arcs|bevel|miter|miter-clip|round";

	var transArr:Array<String> = [];

	public function new(name:String) {
		xml = Xml.createElement(name);
		COUNT++;
		id = get_id();
	}

	// ____________________________________ functions ____________________________________
	// public function noStroke() {
	// 	this.lineWeight = 0;
	// 	this.stroke = 'transparant';
	// }

	public function setID(id:String) {
		this.id = id;
	}

	/**
	 * if you really want to change the postions use this .. not rotate
	 *
	 * might be more clever... it's not really the new position, but the original postion with val
	 * MOVE?
	 *
	 * @param x			new position x
	 * @param y   		(optional) new position y
	 */
	public function setPosition(x:Float, ?y:Float) {
		move = {x: x, y: y};
		if (y == null)
			move = {x: x, y: 0}

		var str = 'translate(${x}';
		if (y != null)
			str += ',${y}';
		str += ')';
		transArr.push(str);
	}

	public function setMove(x:Float, ?y:Float) {
		setPosition(x, y);
	}

	public function setPlusPosition(x:Float, ?y:Float) {
		setPosition(x, y);
	}

	/**
	 * if you really want to change the rotation use this .. not rotate
	 *
	 * @param degree	rotation in degrees
	 * @param x			(optional) center x
	 * @param y   		(optional) center y
	 */
	public function setRotate(degree:Float, ?x:Float, ?y:Float) {
		rotate = degree;
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

	// ____________________________________ helpers for quick stroke and fill changes ____________________________________

	/**
	 * quick way of setting strokeColor, strokeWeight and strokeOpacity
	 *
	 * @param color
	 * @param weight
	 * @param opacity
	 */
	public function setStroke(color:String, weight:Float, ?opacity:Float = 1) {
		this.strokeColor = color;
		this.strokeWeight = weight;
		this.strokeOpacity = opacity;
	}

	/**
	 * use no stroke
	 */
	public function noStroke() {
		this.lineWeight = 0;
		this.strokeColor = 'transparant';
		this.strokeOpacity = 0;
	}

	/**
	 * quick way of setting fillColor and fillOpacity
	 *
	 * @param color
	 * @param opacity
	 */
	public function setFill(color:String, ?opacity:Float = 1) {
		this.fillColor = color;
		this.fillOpacity = 1;
	}

	/**
	 * use no fill
	 */
	public function noFill() {
		this.fillOpacity = 0;
		this.fillColor = 'transparant';
	}

	// ____________________________________ clone ____________________________________
	public function clone():Base {
		trace("WIP");
		return cast(haxe.Json.parse(haxe.Json.stringify(this)), Base);
	}

	// ____________________________________ misc ____________________________________
	function convertID(id:String):String {
		return id.toLowerCase().replace(" ", "_");
	}

	/**
	 *  set everything to default values
	 */
	public function useDefaultsCanvas() {
		if (this.lineWeight == null) {
			this.lineWeight = 0;
		}
		if (this.fillColor == null) {
			this.fillColor = '#000000';
		}
		if (this.strokeColor == null) {
			this.strokeColor = '#000000';
			this.strokeOpacity = 0;
		}
		if (this.fillOpacity == null) {
			this.fillOpacity = 1;
		}
		if (this.strokeOpacity == null) {
			this.strokeOpacity = 1;
		}
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
		value = convertID(value);
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

	function get_fillColor():String {
		return fill;
	}

	function set_fillColor(value:String):String {
		return fill = value;
	}

	function get_fillGradientColor():String {
		return fill;
	}

	function set_fillGradientColor(value:String):String {
		value = convertID(value);
		return fill = 'url(#$value)';
	}

	function get_stroke():String {
		return stroke;
	}

	function set_stroke(value:String):String {
		xml.set('stroke', Std.string(value));
		return stroke = value;
	}

	function get_strokeColor():String {
		return stroke;
	}

	function set_strokeColor(value:String):String {
		return stroke = value;
	}

	function get_lineWeight():Float {
		return lineWeight;
	}

	function set_lineWeight(value:Float):Float {
		xml.set('stroke-width', Std.string(value));
		return lineWeight = value;
	}

	function get_strokeWeight():Float {
		return lineWeight;
	}

	function set_strokeWeight(value:Float):Float {
		return lineWeight = value;
	}

	function get_opacity():Float {
		return opacity;
	}

	function set_opacity(value:Float):Float {
		var v = MathUtil.clamp(value, 0, 1); // should between 0 and 1
		fillOpacity = v;
		strokeOpacity = v;
		// xml.set('fill-opacity', Std.string(v));
		// xml.set('stroke-opacity', Std.string(v));
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
		var v = MathUtil.clamp(value, 0, 1); // should between 0 and 1
		xml.set('stroke-opacity', Std.string(v));
		return strokeOpacity = v;
	}

	function get_fillOpacity():Float {
		return fillOpacity;
	}

	function set_fillOpacity(value:Float):Float {
		var v = MathUtil.clamp(value, 0, 1); // should between 0 and 1
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
		// setRotate(value); // recursion error
		return rotate = value;
	}

	function get_move():Point {
		return move;
	}

	function set_move(value:Point):Point {
		return move = value;
	}

	function get_transform():String {
		return transform;
	}

	function set_transform(value:String):String {
		return transform = value;
	}

	function get_dash():Array<Float> {
		return dash;
	}

	function set_dash(value:Array<Float>):Array<Float> {
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

	// "butt|round|square";
	function get_lineCap():LineCap {
		return lineCap;
	}

	// "butt|round|square";
	function set_lineCap(value:LineCap):LineCap {
		xml.set('stroke-linecap', Std.string(value));
		return lineCap = value;
	}

	// // "arcs|bevel|miter|miter-clip|round";
	function get_lineJoin():LineJoin {
		return lineJoin;
	}

	// // "arcs|bevel|miter|miter-clip|round";
	function set_lineJoin(value:LineJoin):LineJoin {
		xml.set('stroke-linejoin', Std.string(value));
		return lineJoin = value;
	}

	function get_isVisible():Bool {
		return isVisible;
	}

	function set_isVisible(value:Bool):Bool {
		var _opacity = 0;
		if (value) {
			_opacity = 1;
		}
		fillOpacity = _opacity;
		strokeOpacity = _opacity;
		return isVisible = value;
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
