package;

import sketcher.AST.Point;
import sketcher.draw.*;
import sketcher.draw.AST.LineCap;
import sketcher.draw.AST.LineJoin;
import sketcher.util.MathUtil;

class SketcherCore {
	/**
	 * read the settings if needed
	 */
	public var settings:Settings;

	/**
	 * collect all shapes in this array
	 */
	var baseArray:Array<IBase> = [];

	// ____________________________________ make something ____________________________________

	/**
	 * create a rectangle that is first in baseArray
	 * 		doesn't matter when you add the background, it will automaticly be background
	 *
	 * @example			sketch.makeBackground(getColourObj(PINK));
	 *
	 * @param color		color string (red, #fff, rgba(0,0,0,1))
	 * @return Background
	 */
	public function makeBackground(color:String):Background {
		var shape = new Background(color);
		baseArray.unshift(shape); // make sure this is at the start of the array
		return shape;
	}

	/**
	 * Create a text field
	 *
	 * @param str		value of the text you want to create
	 * @param x			(optional) x position of the text (default: 0)
	 * @param y			(optional) y position of the text (default: 0)
	 * @return Text
	 */
	public function makeText(str:String, ?x, ?y):sketcher.draw.Text {
		var shape = new Text(str, x, y);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * create a circl with a center point x and y
	 *
	 * @param x			x position
	 * @param y			y position
	 * @param radius	radius of the circle
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
	 *
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
	 * make a rectangle with the x and y  pos as center point (default center)
	 *
	 * @param x				x position
	 * @param y				y position
	 * @param width			width of the rectangle
	 * @param height		height of the rectangle
	 * @param isCenter		default is centered true, otherwise x and y are top-left start pos
	 * @return Rectangle
	 */
	public function makeButton(x:Float, y:Float, width:Float, height:Float, isCenter = true):Button {
		var shape = new Button(x, y, width, height, isCenter);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * [Description]
	 * @param x				x position
	 * @param y				y position
	 * @param width			width of the rectangle
	 * @param height		height of the rectangle
	 * @param radius		radius of the corners
	 * @param isCenter		default is centered true, otherwise x and y are top-left start pos
	 * @return Rectangle
	 */
	public function makeRoundedRectangle(x:Float, y:Float, width:Float, height:Float, radius:Int, isCenter = true):Rectangle {
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
	 * Create a line between two points (x, y)
	 * (it's syntatic sugar for makeLine)
	 *
	 * @param p1			starting point
	 * @param p2			end point
	 * @return Line
	 */
	public function makeLinePoint(p1:Point, p2:Point):Line {
		var shape = new Line(p1.x, p1.y, p2.x, p2.y);
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
	 * Create polygon with an array of numbers
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
		shape.arrPoint = sides;
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
	 * Create a gradient, and set that gradient on a shape
	 *
	 * @example
	 * ```
	 * 		var gradient = sketch.makeGradient(gradient[0]);
	 * 		gradient.id = 'gradientz';
	 * 		var rect = sketch.makeRectangle(0, 0, w, h, false);
	 * 		rect.id = 'bg with gradient';
	 * 		rect.fillGradientColor = 'gradientz';
	 * ```
	 *
	 * @source 	https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Gradients
	 * 			https://www.w3schools.com/graphics/svg_grad_linear.asp
	 */
	public function makeGradient(colors:Array<String>, isLinear:Bool = true):Gradient {
		var shape = new Gradient(colors, isLinear);
		baseArray.push(shape);
		return shape;
	}

	// hmmm, is it really usefull?????
	// public function makeRectWithGradient(x, y, w, h, colors:Array<String>, isLinear:Bool = true):Gradient {

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
	 * [Description]
	 * @param x
	 * @param y
	 * @param img
	 * @param width
	 * @param height
	 * @param isCenter
	 * @return Image
	 */
	#if js
	public function makeImageFromImage(x:Float, y:Float, img:js.html.Image, width:Float, height:Float, ?isCenter:Bool = false):Image {
		var shape = new Image(x, y, '', width, height, isCenter);
		shape.image = img;
		baseArray.push(shape);
		return shape;
	}
	#end

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
			// mute(_base.id, 1);
			for (i in 0...baseArray.length) {
				var base:IBase = baseArray[i];
				// mute(base.id, 2);
				if (base == _base) {
					baseArray[i] = null; // the reason there is base == null!
				}
			}
		}
		baseArray.push(shape);
		return shape;
	}

	/**
	 *
	 * @param array		array of items (IBase), a collection of shapes or groups
	 * @example			sketch.makeMask();
	 *
	 * @return Mask
	 */
	public function makeMask(array:Array<IBase>):Mask {
		var shape = new Mask(array);
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
	 *
	 * @param array		array of items (IBase), a collection of shapes or groups
	 * @example			sketch.makeMarker();
	 *
	 * @return Marker
	 */
	public function makeMarker(array:Array<IBase>):Marker {
		var shape = new Marker(array);
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

	public function makeMirror(?dir:Mirror.MirrorType):Mirror {
		var shape = new Mirror(dir);
		// only needed for svg
		if (settings.type.toLowerCase() == 'svg') {
			shape.baseArray = baseArray;
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
		polyline.strokeColor = color;
		polyline.strokeWeight = 1;
		polyline.fillColor = color;
		polyline.lineCap = LineCap.Butt;
		polyline.lineJoin = LineJoin.Miter;
		baseArray.push(polyline);
		return polyline;
	}

	/**
	 * big ex if needed, don't forget to set the stroke and fill
	 *
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
		polyline.lineCap = LineCap.Butt;
		polyline.lineJoin = LineJoin.Bevel;
		baseArray.push(polyline);
		return polyline;
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
}
