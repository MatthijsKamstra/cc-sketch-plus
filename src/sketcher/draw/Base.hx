package sketcher.draw;

import sketcher.AST;
import sketcher.draw.AST.LineCap;
import sketcher.draw.AST.LineJoin;
import sketcher.util.MathUtil;

using StringTools;

class Base {
	public static var COUNT:Int = 0;

	public var count(get, null):Int;

	public var xml:Xml;

	@:isVar public var id(get, set):String;

	// Positions the shape horizontally from the origin // Positions the shape vertically from the origin.
	@:isVar public var x(get, set):Float;
	@:isVar public var y(get, set):Float;

	// use rx and ry for ration centers
	@:isVar public var rx(get, set):Float;
	@:isVar public var ry(get, set):Float;

	@:isVar public var maskID(get, set):String;

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
	@:isVar public var rotate(get, null):Float;
	@:isVar public var move(get, set):Point; // move x/y

	@:isVar public var transform(get, set):String;

	// dashed line
	@:isVar public var dash(get, set):Array<Float> = [];

	@:isVar public var desc(get, set):String;

	@:isVar public var className(get, set):String;

	// line specific
	@:isVar public var lineCap(get, set):LineCap; // "butt|round|square";
	@:isVar public var lineJoin(get, set):LineJoin; // "arcs|bevel|miter|miter-clip|round";

	// drop shadow
	@:isVar public var shadowColor(get, set):String;
	@:isVar public var shadowBlur(get, set):Float;
	@:isVar public var shadowOffsetX(get, set):Float;
	@:isVar public var shadowOffsetY(get, set):Float;

	var transArr:Array<String> = [];

	public function new(name:String) {
		xml = Xml.createElement(name);
		COUNT++;
		id = get_id();
	}

	// ____________________________________ functions ____________________________________

	public function setID(id:String) {
		this.id = id;
	}

	public function setMask(id:String) {
		xml.set('mask', 'url(#$id)');
		this.maskID = id;
	}

	// ____________________________________ transitions ____________________________________

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
	 * @param rx		(optional) center x
	 * @param ry   		(optional) center y
	 */
	public function setRotate(degree:Float, ?rx:Float = 0, ?ry:Float = 0) {
		this.rotate = degree;
		this.rx = rx;
		this.ry = ry;

		var str = 'rotate(${degree}';
		if (rx != 0)
			str += ',${rx}';
		if (ry != 0)
			str += ',${ry}';
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
	 * @param weight		default is 1
	 * @param opacity		default is 1 otherwise a value between 0 and 1
	 */
	public function setStroke(color:String, ?weight:Float = 1, ?opacity:Float = 1) {
		this.strokeColor = color;
		this.strokeWeight = weight;
		this.strokeOpacity = opacity;
		return this;
	}

	/**
	 * use no stroke
	 */
	public function noStroke() {
		this.lineWeight = 0;
		this.strokeColor = 'transparant';
		this.strokeOpacity = 0;
		return this;
	}

	/**
	 * quick way of setting fillColor and fillOpacity
	 *
	 * @param color
	 * @param opacity		default is 1 otherwise a value between 0 and 1
	 */
	public function setFill(color:String, ?opacity:Float = 1) {
		this.fillColor = color;
		this.fillOpacity = opacity;
		return this;
	}

	/**
	 * use no fill
	 */
	public function noFill() {
		this.fillOpacity = 0;
		this.fillColor = 'transparant';
		return this;
	}

	/**
	 * [Description]
	 * @param color
	 * @param blur		A non-negative float specifying the level of shadow blur, where 0 represents no blur and larger numbers represent increasingly more blur
	 * @param offsetx
	 * @param offsety
	 */
	public function setShadow(color:String, blur:Float = 0, offsetx:Float = 0, offsety:Float = 0) {
		this.shadowColor = color;
		this.shadowBlur = blur;
		this.shadowOffsetX = offsetx;
		this.shadowOffsetY = offsety;
	}

	/**
	 * (chaining) methode to set lineCaps and lineJoin
	 *
	 * @param linecap			default round
	 * @param linejoin			default round
	 */
	public function setLineEnds(?linecap:LineCap = LineCap.Round, ?linejoin:LineJoin = LineJoin.Round) {
		this.lineCap = linecap;
		this.lineJoin = linejoin;
		return this;
	}

	/**
	 * possible to set a class on a element
	 * @param className
	 */
	public function setClass(className:String) {
		this.className = className;
		return this;
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

	// ____________________________________ defaults for canvas ____________________________________

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
		// make sure the default settings are used for every new shape
		if (this.lineCap == null) {
			this.lineCap = LineCap.Butt;
		}
		if (this.lineJoin == null) {
			this.lineJoin = LineJoin.Miter;
		}
	}

	// ____________________________________ getter/setter ____________________________________

	function get_maskID():String {
		return maskID;
	}

	function set_maskID(value:String):String {
		return maskID = value;
	}

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

	function get_rx():Float {
		return rx;
	}

	function set_rx(value:Float):Float {
		return rx = value;
	}

	function get_ry():Float {
		return ry;
	}

	function set_ry(value:Float):Float {
		return ry = value;
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

	function get_shadowColor():String {
		return shadowColor;
	}

	function set_shadowColor(value:String):String {
		return shadowColor = value;
	}

	function get_shadowBlur():Float {
		return shadowBlur;
	}

	function set_shadowBlur(value:Float):Float {
		return shadowBlur = value;
	}

	function get_shadowOffsetX():Float {
		return shadowOffsetX;
	}

	function set_shadowOffsetX(value:Float):Float {
		return shadowOffsetX = value;
	}

	function get_shadowOffsetY():Float {
		return shadowOffsetY;
	}

	function set_shadowOffsetY(value:Float):Float {
		return shadowOffsetY = value;
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

	function get_className():String {
		return className;
	}

	function set_className(value:String):String {
		xml.set('class', Std.string(value));
		return className = value;
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
