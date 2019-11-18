package;

import js.Browser.*;
import draw.*;
import cc.AST.Point;

class Sketcher {
	var settings:Settings;
	// var paper:Dynamic;
	var element:js.html.Element;
	var baseArray:Array<IBase> = [];
	var svg:String;
	var canvas:js.html.CanvasElement;

	public var CANVAS_ID:String = "sketcher_canvas";
	public var SVG_ID:String = "sketcher_svg";
	public var WRAPPER_ID:String = "sketcher_wrapper";

	public static var ctx:js.html.CanvasRenderingContext2D;

	public function new(settings:Settings) {
		this.settings = settings;

		Sketch.Global.w = settings.width;
		Sketch.Global.h = settings.height;

		if (settings.elementID != null) {
			WRAPPER_ID = settings.elementID;
		}

		if (settings.scale == true) {
			var node = document.createElement('style');
			node.innerHTML = 'svg {width: 100%; height: 100%;}';
			document.body.appendChild(node);
		}

		if (settings.padding != null && settings.padding > 0) {
			var node = document.createElement('style');
			node.innerHTML = 'svg {margin: ${settings.padding}px; }';
			document.body.appendChild(node);
		}
	}

	// ____________________________________ util to append ____________________________________

	public function appendTo(element:js.html.Element):Sketcher {
		if (element == null) {
			return this;
		}
		this.element = element;

		if (settings.type == 'canvas') {
			canvas = document.createCanvasElement();
			canvas.width = settings.width;
			canvas.height = settings.height;
			canvas.id = CANVAS_ID;
			ctx = canvas.getContext2d();
			element.appendChild(canvas);
		}
		return this;
	}

	// ____________________________________ make something ____________________________________

	/**
	 * Create a text field
	 *
	 * @param str		value of the text you want to create
	 * @param x			(optional?) x position of the text
	 * @param y			(optional) y position of the text
	 * @return Text
	 */
	public function makeText(str:String, ?x, ?y):Text {
		var shape = new Text(str, x, y);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x			(optional?) x position of the text
	 * @param y			(optional) y position of the text
	 * @param radius
	 * @return Circle
	 */
	public function makeCircle(x:Float, y:Float, radius:Float):Circle {
		var shape = new Circle(x, y, radius);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * make a rectangle with the x and y  pos as center point
	 * @param x			(optional?) x position of the text
	 * @param y			(optional) y position of the text
	 * @param width
	 * @param height
	 * @param isCenter	default is centered true, otherwise x and y are top-left start pos
	 * @return Rectangle
	 */
	public function makeRectangle(x:Float, y:Float, width:Float, height:Float, isCenter = true):Rectangle {
		var shape = new Rectangle(x, y, width, height, isCenter);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x			(optional?) x position of the text
	 * @param y			(optional) y position of the text
	 * @param width
	 * @param height
	 * @param isCenter = true
	 * @return Rectangle
	 */
	public function makeRectangleInt(x:Int, y:Int, width:Int, height:Int, isCenter = true):Rectangle {
		var shape = new Rectangle(x, y, width, height);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x			(optional?) x position of the text
	 * @param y			(optional) y position of the text
	 * @param width
	 * @param height
	 * @param radius
	 * @param isCenter = true
	 * @return Rectangle
	 */
	public function makeRoundedRectangle(x, y, width, height, radius, isCenter = true):Rectangle {
		if (!isCenter) {
			x = Math.round(width / 2);
			y = Math.round(height / 2);
		}
		var shape = new Rectangle(x, y, width, height);
		shape.radius = radius;
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Create a line between two points (x, y)
	 *
	 * @param x1			first x position
	 * @param y1			first y position
	 * @param x2			second x position
	 * @param y2			second x position
	 * @return Line
	 */
	public function makeLine(x1, y1, x2, y2):Line {
		var shape = new Line(x1, y1, x2, y2);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Create an ellipse with a radius x and radius y
	 *
	 * @param x			x position
	 * @param y			y position
	 * @param rx		radius in x dir
	 * @param ry		radius in y dir
	 * @return Ellipse
	 */
	public function makeEllipse(x, y, rx, ry):Ellipse {
		var shape = new Ellipse(x, y, rx, ry);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 *  (example [10,11,20,21] translates to point 1: (x: 10, y: 11) and point 1: (x: 20, y: 21)
	 *
	 * @param sides			an array of x and y position
	 * @return Polygon
	 */
	public function makePolygon(sides:Array<Float>):Polygon {
		var shape = new Polygon(sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Create polygon with an array of points ( {x:22, y:33} )
	 * (it's syntatic sugar for makePolygon)
	 *
	 * @param sides		an array of points [{x:22, y:33}]
	 * @return Polygon
	 */
	public function makePolygonPoint(sides:Array<Point>):Polygon {
		var _sides:Array<Float> = [];
		for (i in sides) {
			_sides.push(i.x);
			_sides.push(i.y);
		}
		var shape = new Polygon(_sides);
		baseArray.push(shape);
		return shape;
	}

	// public function makePolygonInt(sides:Array<Int>):Polygon {
	// 	var shape = new Polygon(sides);
	// 	baseArray.push(shape);
	// 	return shape;
	// }

	/**
	 * [Description]
	 * @param x			x position
	 * @param y			y position
	 * @param str
	 * @return Path
	 */
	public function makePath(x, y):Path {
		var shape = new Path(x, y);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param sides
	 * @return PolyLine
	 */
	public function makePolyLine(sides):PolyLine {
		var shape = new PolyLine(sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Group is an collection of IBase items
	 * usefull if you want to rotate/color/stroke-weight a group of items at the same time.
	 * In Illustrator it will be layer, so usefull to group items to make a more structured file
	 *
	 * @param array		array of items (IBase), a collection of shapes
	 * @return Group
	 */
	public function makeGroup(array:Array<IBase>):Group {
		var shape = new Group(array);
		for (j in 0...array.length) {
			var _base = array[j];
			for (i in 0...baseArray.length) {
				var base:IBase = baseArray[i];
				if (base == _base) {
					baseArray[i] = null;
				}
			}
		}
		baseArray.push(shape);
		return shape;
	}

	/**
	 * helpfull debug tool, register point
	 *
	 * ```
	 * var sketch = Sketcher.create(params).appendTo(elem);
	 * sketch.makeX(10,10);
	 * ```
	 *
	 * @param x			position in x dir (will automaticly be rounded to Int) but why?
	 * @param y			position in y dir (will automaticly be rounded to Int)
	 * @param color		(optional) default color is red
	 * @return PolyLine
	 */
	public function makeX(x:Float, y:Float, ?color:String = 'red'):PolyLine {
		var cx = Math.round(x);
		var cy = Math.round(y);
		var r = 5;

		var polyline = new PolyLine([
			    cx,     cy,
			cx - r,     cy,
			    cx,     cy,
			cx + r,     cy,
			    cx,     cy,
			    cx, cy - r,
			    cx,     cy,
			    cx, cy + r,
			    cx,     cy,
		]);
		polyline.id = 'registration_marker_${polyline.count}';
		polyline.desc = 'Registration Marker\nx: ${cx}, y: ${cy}';
		polyline.stroke = color;
		baseArray.push(polyline);
		return polyline;
	}

	/**
	 * basic reset
	 */
	public function clear() {
		baseArray = [];
		element.innerHTML = '';
	}

	/**
	 * all elements created in code, are store here,
	 * this way its possible to add a element (for example a rectangle)
	 * and later put that rectangle in a group
	 *
	 * @return Array<IBase>
	 */
	public function getBaseArray():Array<IBase> {
		return baseArray;
	}

	/**
	 * get the SVG (as String) used for this sketch
	 *
	 * @return String
	 */
	public function getSVG():String {
		// var svg:js.html.svg.SVGElement = cast wrapperDiv.getElementsByTagName('svg')[0];
		var div = document.getElementById(WRAPPER_ID);
		return div.innerHTML;
	}

	/**
	 * get the SVGElement used for the sketch
	 *
	 * @return js.html.svg.SVGElement
	 */
	public function getSVGElement():js.html.svg.SVGElement {
		// var svg:js.html.svg.SVGElement = cast wrapperDiv.getElementsByTagName('svg')[0];
		var svg:js.html.svg.SVGElement = cast document.getElementById(SVG_ID);
		return svg;
	}

	// ____________________________________ update ____________________________________

	public function update() {
		// trace('WIP update');
		if (element == null) {
			// make sure the element exists
			// console.warn('element doesn\'t exist in DOM (${element})');
			return;
		}
		trace('type:${settings.type}, id:${element.id}');
		if (settings.type == 'svg') {
			// [mck] TODO change string into XML!!!
			var svgW = '${settings.width}';
			var svgH = '${settings.height}';
			if (settings.sizeType != null) {
				svgW += '${settings.sizeType}';
				svgH += '${settings.sizeType}';
			}
			var paper = '<?xml version="1.0" standalone="no"?><svg width="${svgW}" height="${svgH}" viewBox="0 0 ${svgW} ${svgH}" version="1.1" id="${SVG_ID}" xmlns="http://www.w3.org/2000/svg">';
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				if (base == null)
					continue;

				// if (base.type == 'Group') {
				// 	trace('groups do this');
				// 	cast(base, draw.Group).test();
				// }
				var draw = base.svg(settings);
				// trace(base.toString());
				// trace(draw);
				paper += draw;
			}
			paper += '</svg>';
			element.innerHTML = paper;
		} else {
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				trace(base.type);
				base.ctx(ctx);
			}
		}
	}

	// [mck] TODO create settings AST to have possible object send as well?
	public static function create(settings:Settings):Sketcher {
		var sketcher = new Sketcher(settings);
		sketcher.baseArray = []; // make sure it's empty
		return sketcher;
	}
}
