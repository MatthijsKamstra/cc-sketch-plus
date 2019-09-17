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

	public static var ctx:js.html.CanvasRenderingContext2D;

	public function new(settings:Settings) {
		this.settings = settings;

		Sketch.Global.w = settings.width;
		Sketch.Global.h = settings.height;

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
			canvas.id = 'canvas';
			ctx = canvas.getContext2d();
			element.appendChild(canvas);
		}
		return this;
	}

	// ____________________________________ make something ____________________________________

	/**
	 * [Description]
	 * @param str
	 * @param x
	 * @param y
	 * @return Text
	 */
	public function makeText(str:String, ?x, ?y):Text {
		var shape = new Text(str, x, y);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x
	 * @param y
	 * @param radius
	 * @return Circle
	 */
	public function makeCircle(x, y, radius):Circle {
		var shape = new Circle(x, y, radius);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * make a rectangle with the x and y  pos as center point
	 * @param x
	 * @param y
	 * @param width
	 * @param height
	 * @return Rectangle
	 */
	public function makeRectangle(x:Float, y:Float, width:Float, height:Float, isCenter = true):Rectangle {
		var shape = new Rectangle(x, y, width, height);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x
	 * @param y
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
	 * @param x
	 * @param y
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
	 * [Description]
	 * @param x1
	 * @param y1
	 * @param x2
	 * @param y2
	 * @return Line
	 */
	public function makeLine(x1, y1, x2, y2):Line {
		var shape = new Line(x1, y1, x2, y2);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x
	 * @param y
	 * @param rx
	 * @param ry
	 * @return Ellipse
	 */
	public function makeEllipse(x, y, rx, ry):Ellipse {
		var shape = new Ellipse(x, y, rx, ry);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param sides
	 * @return Polygon
	 */
	public function makePolygon(sides:Array<Float>):Polygon {
		var shape = new Polygon(sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * create polygon with points ( {x:22, y:33} )
	 * @param sides
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
	 * @param x
	 * @param y
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
	 * [Description]
	 * @param array
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
	 * @param x		position in x dir (will automaticly be rounded to Int)
	 * @param y		position in y dir (will automaticly be rounded to Int)
	 * @param color	(optional) default color is red
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

	public function clear() {
		baseArray = [];
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
			var paper = '<?xml version="1.0" standalone="no"?><svg width="${settings.width}" height="${settings.height}" viewBox="0 0 ${settings.width} ${settings.height}" version="1.1" id="sketcher" xmlns="http://www.w3.org/2000/svg">';
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				if (base == null)
					continue; // groups do this

				// if (base.type == 'Group') {
				// 	// trace('ggggg');
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
