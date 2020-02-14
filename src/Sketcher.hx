package;

// import cc.draw.Gradient;
import js.Browser.*;
import draw.*;
import sketcher.draw.*;
import sketcher.AST.Point;

class Sketcher {
	var element:js.html.Element;
	var baseArray:Array<IBase> = [];

	/**
	 * read the settings if needed
	 */
	public var settings:Settings;

	/**
	 * canvas used for graphics
	 */
	public var canvas:js.html.CanvasElement;

	// canvas context
	public static var ctx:js.html.CanvasRenderingContext2D;

	// webgl?
	public static var gl:js.html.webgl.RenderingContext;

	/**
	 * the svg string (string injected into div)
	 */
	public var svg:String; // should be the svg/xml

	public var CANVAS_ID:String = "sketcher_canvas";
	public var WEBGL_ID:String = "sketcher_canvas_webgl";
	public var SVG_ID:String = "sketcher_svg";
	public var WRAPPER_ID:String = "sketcher_wrapper";

	public function new(settings:Settings) {
		this.settings = settings;

		Sketcher.Globals.w = settings.width;
		Sketcher.Globals.h = settings.height;

		if (settings.elementID != null) {
			WRAPPER_ID = settings.elementID;
		}

		if (settings.scale == true) {
			var node = document.createElement('style');
			node.innerHTML = '
			.sketcher-wrapper{width: 100%; height: 100%; padding: 0; margin: 0; display: flex; align-items: center;	justify-content: center;}
			svg {width: 100%; }
			canvas{width: 100%;}
			';
			document.body.appendChild(node);
		}

		if (settings.padding != null && settings.padding > 0) {
			var node = document.createElement('style');
			node.innerHTML = '
			.sketcher-wrapper{width: 100%; height: 100%; padding: 0; margin: 0; display: flex; align-items: center;	justify-content: center;}
			svg {margin: ${settings.padding}px; width: 100%; }
			canvas {margin: ${settings.padding}px; width: 100%; }
			';
			document.body.appendChild(node);
		}
	}

	// ____________________________________ util to append ____________________________________

	public function appendTo(element:js.html.Element):Sketcher {
		if (element == null) {
			return this;
		}
		this.element = element;

		// console.log(settings);
		// console.log(element);

		switch (settings.type) {
			case 'svg':
			// trace('svg');
			case 'canvas':
				// trace('canvas');
				canvas = document.createCanvasElement();
				canvas.width = settings.width;
				canvas.height = settings.height;
				canvas.id = CANVAS_ID;
				ctx = canvas.getContext2d();
				element.appendChild(canvas);
			// console.log(canvas);
			case 'webgl':
				// trace('webgl');
				canvas = document.createCanvasElement();
				canvas.width = settings.width;
				canvas.height = settings.height;
				canvas.id = WEBGL_ID;
				gl = canvas.getContextWebGL();
				element.appendChild(canvas);
			default:
				trace("case '" + settings.type.toLowerCase() + "': trace ('" + settings.type.toLowerCase() + "');");
		}

		return this;
	}

	// ____________________________________ make something ____________________________________

	/**
	 * Create a text field
	 *
	 * @param str		value of the text you want to create
	 * @param x			(optional) x position of the text (default: 0)
	 * @param y			(optional) y position of the text (default: 0)
	 * @return Text
	 */
	public function makeText(str:String, ?x, ?y):Text {
		var shape = new Text(str, x, y);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * create a circl with a center point x and y
	 *
	 * @param x			x position
	 * @param y			y position
	 * @param radius
	 * @return Circle
	 */
	public function makeCircle(x:Float, y:Float, radius:Float):Circle {
		var shape = new Circle(x, y, radius);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * make a rectangle with the x and y  pos as center point (default center)
	 *
	 * @param x				x position
	 * @param y				y position
	 * @param width			width of the rectangle
	 * @param height		height of the rectangle
	 * @param isCenter		default is centered true, otherwise x and y are top-left start pos
	 * @return Rectangle
	 */
	public function makeRectangle(x:Float, y:Float, width:Float, height:Float, isCenter = true):Rectangle {
		var shape = new Rectangle(x, y, width, height, isCenter);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Not sure why I made this, but at that time it seemed really important
	 * @param x				x position
	 * @param y				y position
	 * @param width			width of the rectangle
	 * @param height		height of the rectangle
	 * @param isCenter		default is centered true, otherwise x and y are top-left start pos
	 * @return Rectangle
	 */
	public function makeRectangleInt(x:Int, y:Int, width:Int, height:Int, isCenter = true):Rectangle {
		var shape = new Rectangle(x, y, width, height);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x				x position
	 * @param y				y position
	 * @param width			width of the rectangle
	 * @param height		height of the rectangle
	 * @param radius
	 * @param isCenter		default is centered true, otherwise x and y are top-left start pos
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
	 * The <polyline> element is used to create any shape that consists of only straight lines (that is connected at several points)
	 *  (example [10,11,20,21] translates to point 1: (x: 10, y: 11) and point 1: (x: 20, y: 21)
	 *
	 * @example 	var polyline = sketch.makePolyLine([10,11,20,21]);
	 *
	 * @param sides			array of x and y position (uneven numbers are x, even number are y)
	 * @return PolyLine
	 */
	public function makePolyLine(sides:Array<Float>):PolyLine {
		var shape = new PolyLine(sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Create polyline with an array of points ( {x:22, y:33} )
	 * (it's syntatic sugar for makePolyLine)
	 *
	 * @example
	 *			var polyline = sketch.makePolyLinePoint(_pointArray);
	 *			polyline.strokeWeight = 1;
	 *			polyline.strokeColor = getColourObj(_color1);
	 *			polyline.fillOpacity = 0;
	 *
	 * @param sides		array of points [{x:22, y:33}]
	 * @return polyline
	 */
	public function makePolyLinePoint(sides:Array<Point>):PolyLine {
		var _sides:Array<Float> = [];
		for (i in sides) {
			_sides.push(i.x);
			_sides.push(i.y);
		}
		var shape = new PolyLine(_sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * @source 	https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Gradients
	 * 			https://www.w3schools.com/graphics/svg_grad_linear.asp
	 */
	public function makeGradient(color0:String, color1:String, isLinear:Bool = true):Gradient {
		var shape = new Gradient(color0, color1, isLinear);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * add an image
	 *
	 * @source 	https://developer.mozilla.org/en-US/docs/Web/SVG/Element/image
	 *
	 * @param x				Positions the image horizontally from the origin
	 * @param y				Positions the image vertically from the origin.
	 * @param href			Points at a URL for the image file.
	 * @param width			The width the image renders at. Unlike HTML's <img>, this attribute is required.
	 * @param height		The height the image renders at. Unlike HTML's <img>, this attribute is required.
	 * @param isCenter
	 * @return Image
	 */
	public function makeImage(x:Float, y:Float, href:String, width:Float, height:Float, ?isCenter:Bool = false):Image {
		var shape = new Image(x, y, href, width, height, isCenter);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * Group is an collection of IBase items
	 * usefull if you want to rotate/color/stroke-weight a group of items at the same time.
	 * In Illustrator it will be layer, so usefull to group items to make a more structured file
	 *
	 * @param array		array of items (IBase), a collection of shapes or groups
	 * @return Group
	 */
	public function makeGroup(array:Array<IBase>):Group {
		var shape = new Group(array);
		for (j in 0...array.length) {
			var _base = array[j];
			for (i in 0...baseArray.length) {
				var base:IBase = baseArray[i];
				if (base == _base) {
					baseArray[i] = null; // the reason there is base == null!
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
	 * not sure this is needed, but will leave this here for now
	 * @param x
	 * @param y
	 * @param color
	 * @return PolyLine
	 */
	public function makeXCross(x:Float, y:Float, size:Float):PolyLine {
		var cx = x;
		var cy = y;
		var r = size;

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
		polyline.id = 'xcross_${polyline.count}';
		polyline.desc = 'xcross\nx: ${cx}, y: ${cy}, size:${size}';
		baseArray.push(polyline);
		return polyline;
	}

	/**
	 * basic reset
	 */
	public function clear() {
		baseArray = [];
		if (settings.type.toLowerCase() == 'svg')
			element.innerHTML = '';
		if (settings.type.toLowerCase() == 'canvas')
			ctx.clearRect(0, 0, settings.width, settings.height);
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

	/**
	 * svg will be generated in array and objects
	 *
	 * So to generate the svg, you need to update it!
	 */
	public function update() {
		// trace('WIP update');

		if (element == null) {
			// make sure the element exists
			// console.warn('element doesn\'t exist in DOM (${element})');
			return;
		}
		// trace('type:${settings.type}, id:${element.id}');

		switch (settings.type) {
			case 'svg':
				// trace('svg');
				// [mck] TODO change string into XML!!!
				var svgW = '${settings.width}';
				var svgH = '${settings.height}';
				if (settings.sizeType != null) {
					svgW += '${settings.sizeType}';
					svgH += '${settings.sizeType}';
				}
				var _xml = '<?xml version="1.0" standalone="no"?><svg width="${svgW}" height="${svgH}" viewBox="0 0 ${svgW} ${svgH}" version="1.1" id="${SVG_ID}" xmlns="http://www.w3.org/2000/svg">';
				var content = '';
				var defs = '<defs>';
				for (i in 0...baseArray.length) {
					var base = baseArray[i];

					if (base == null)
						continue; // with the creation of groups there are base == null

					// if (base.type == 'Group') {
					// 	trace('groups do this');
					// 	cast(base, draw.Group).test();
					// }
					var draw = base.svg(settings);
					// trace(base.toString());
					// trace(draw);
					if (base.type == 'gradient') {
						defs += draw;
					} else {
						content += draw;
					}
				}
				_xml += defs + '</defs>';
				_xml += content + '</svg>';
				svg = _xml; // external acces?
				element.innerHTML = _xml;
			case 'canvas':
				// trace('canvas');
				for (i in 0...baseArray.length) {
					var base = baseArray[i];
					if (base == null)
						continue; // with the creation of groups there are base == null
					// trace(base.type);
					base.ctx(ctx);
				}
			case 'webgl':
				trace('webgl');
				for (i in 0...baseArray.length) {
					var base = baseArray[i];
					if (base == null)
						continue; // with the creation of groups there are base == null
					// trace(base.type);
					base.gl(gl);
				}
			default:
				trace("case '" + settings.type + "': trace ('" + settings.type + "');");
		}
	}

	// [mck] TODO create settings AST to have possible object send as well?
	public static function create(settings:Settings):Sketcher {
		var sketcher = new Sketcher(settings);
		sketcher.baseArray = []; // make sure it's empty
		return sketcher;
	}
}

/**
 * Sketcher.Globals has values you can access easily
 *
 * @usage:
 * 		import Sketcher.Globals.*;
 *
 * @source
 * 			https://groups.google.com/forum/#!topic/haxelang/CPbyE3WCvnc
 * 			https://gist.github.com/nadako/5913724
 */
class Globals {
	public static var MOUSE_DOWN:String = 'mousedown';
	public static var MOUSE_UP:String = 'mouseup';
	public static var MOUSE_MOVE:String = 'mousemove';
	public static var KEY_DOWN:String = 'keydown';
	public static var KEY_UP:String = 'keyup';
	public static var RESIZE:String = 'resize';
	public static var mouseX:Int;
	public static var mouseY:Int;
	public static var mouseMoved:Bool;
	public static var mouseDown:Bool;
	public static var keyDown:Int;
	public static var keyUp:Int;
	public static var mousePressed:Int = 0;
	public static var mouseReleased:Int = 0;
	public static var isFullscreen:Bool = false;
	public static var TWO_PI:Float = Math.PI * 2;
	// allows me global access to canvas and it’s width and height properties
	public static var w:Int;
	public static var h:Int;
	// public static var width:Int;
	// public static var height:Int;
}
