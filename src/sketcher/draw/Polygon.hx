package sketcher.draw;

import sketcher.util.MathUtil;
import sketcher.util.ColorUtil;
import sketcher.AST.Point;
import js.Browser.*;

class Polygon extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'Polygon'; // base (get class name?)

	@:isVar public var arr(get, set):Array<Float>; // collection of points

	@:isVar public var arrPoint(get, set):Array<Point>;

	// for storing the function sides centerpoints
	public var cx:Float;
	public var cy:Float;
	public var width:Float = null;
	public var height:Float = null;

	public var point_top_left:Point;
	public var point_top_right:Point;
	public var point_bottom_left:Point;
	public var point_bottom_right:Point;

	public function new(arr:Array<Float>) {
		this.arr = arr;
		calculateSize();
		super('polygon');
	}

	public function calculateSize() {
		if (this.arrPoint == null) {
			this.arrPoint = convertArr();
		}

		var lt:Point = {x: null, y: null};
		var rt:Point = {x: null, y: null};
		var lb:Point = {x: null, y: null};
		var rb:Point = {x: null, y: null};

		for (i in 0...this.arrPoint.length) {
			var p:Point = this.arrPoint[i];
			// trace(p);
			// trace(p.x <= lt.x);
			// trace(p.y <= lt.y);

			//
			if (lt.x == null)
				lt = {x: p.x, y: p.y};
			if (rt.x == null)
				rt = {x: p.x, y: p.y};
			if (lb.x == null)
				lb = {x: p.x, y: p.y};
			if (rb.x == null)
				rb = {x: p.x, y: p.y};

			//
			// console.warn(lt, rt, lb, rb);
			if (p.x <= lt.x) {
				lt.x = p.x;
			}
			if (p.y <= lt.y) {
				lt.y = p.y;
			}
			if (p.x >= rt.x) {
				rt.x = p.x;
			}
			if (p.y <= rt.y) {
				rt.y = p.y;
			}
			// console.warn(lt, rt, lb, rb);
			if (p.x <= lb.x) {
				lb.x = p.x;
			}
			if (p.y >= lb.y) {
				lb.y = p.y;
			}
			if (p.x >= rb.x) {
				rb.x = p.x;
			}
			if (p.y >= rb.y) {
				rb.y = p.y;
			}
		}

		this.x = lt.x;
		this.y = lt.y;
		this.width = rt.x - lt.x;
		this.height = rb.y - rt.y;
		this.cx = lt.x + (this.width / 2);
		this.cy = lt.y + (this.height / 2);

		this.point_top_left = lt;
		this.point_top_right = rt;
		this.point_bottom_left = lb;
		this.point_bottom_right = rb;

		// console.group('lt, rt, lb, rb');
		// console.log(lt); // :Point = {x: null, y: null};
		// console.log(rt); // :Point = {x: null, y: null};
		// console.log(lb); // :Point = {x: null, y: null};
		// console.log(rb); // :Point = {x: null, y: null};
		// console.groupEnd();
	}

	public function svg(?settings:Settings):String {
		calculateSize();

		var str = '';
		for (i in 0...this.arr.length) {
			var value = this.arr[i];
			str += '${value} ';
		}
		xml.set('points', str);

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.groupCollapsed('Polygon (${id}) info canvas');
			console.warn('doesn\'t work\n- move\n- rotate (for weird shapes, works for sides)\n- lineJoin');
			console.groupEnd();
			Polygon.ISWARN = true;
		}

		// console.info('1. ' + this.lineCap);

		// set everything to default values
		useDefaultsCanvas();

		if (this.lineCap != null) {
			ctx.lineCap = cast this.lineCap;
		}

		// console.info('2. ' + this.lineCap);

		ctx.lineWidth = this.lineWeight;
		var _fillColor = ColorUtil.assumption(this.fillColor);

		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);
		var _strokeColor = ColorUtil.assumption(this.strokeColor);

		ctx.strokeStyle = ColorUtil.getColourObj(_strokeColor, this.strokeOpacity);
		if (this.dash != null) {
			ctx.setLineDash(this.dash);
		}
		// trace(this.rotate, this.move);
		ctx.beginPath();

		// get all points, converted
		var _pointArray = convertArr();

		if (this.rotate != null) {
			// trace('rotate: ${this.rotate}');
			// trace('cx: ${this.cx}');
			// trace('cy: ${this.cy}');

			// todo:  this might fix the sides, but not the normal polygon
			// fix later
			ctx.save();

			ctx.translate(this.rx, this.ry);
			ctx.rotate(MathUtil.radians(this.rotate));

			for (i in 0..._pointArray.length) {
				var p = _pointArray[i];
				if (i == 0) {
					ctx.moveTo(p.x - this.rx, p.y - this.ry);
				} else {
					ctx.lineTo(p.x - this.rx, p.y - this.ry);
				}
			}

			ctx.restore();
		} else {
			for (i in 0..._pointArray.length) {
				var p = _pointArray[i];
				if (i == 0) {
					ctx.moveTo(p.x, p.y);
				} else {
					ctx.lineTo(p.x, p.y);
				}
			}
		}
		ctx.closePath();
		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null && this.lineWeight != 0) {
			ctx.stroke();
		}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

	function convertArr():Array<Point> {
		var _pointArray = [];
		for (i in 0...this.arr.length) {
			if (i % 2 == 0) {
				var x = this.arr[i];
				var y = this.arr[i + 1];
				_pointArray.push({x: x, y: y});
			}
		}
		return _pointArray;
	}

	// ____________________________________ update the arr, without generating new var ____________________________________
	// public function update(arr:Array<Float>) {
	// 	this.arr = arr;
	// }
	// ____________________________________ public functions ____________________________________
	// not sure what this does?????
	//
	public function getPoint(id:Int):Point {
		// [mck] do check for total nr
		if (id * 2 > arr.length) {
			trace("not in this length");
		}
		var p = {x: arr[id * 2], y: arr[(id * 2) + 1]};
		return p;
	}

	/**
	 * Create shape with polygon
	 * 		- triangle with 3 sides
	 * 		- square with 4 sides
	 * 		- pentagon with 5 sides
	 * 		- hexagon with 6 sides
	 * 		- heptagon with 27 sides
	 *
	 * @example
	 *				var _polygon = sketch.makePolygon([]);
	 *				_polygon.sides(sh.x, sh.y, 6, sh.size);
	 *				_polygon.rotate = sh.degree;
	 *				_polygon.strokeColor = getColourObj(BLACK);
	 *				_polygon.strokeWeight = 1;
	 *				_polygon.fillOpacity = 0;
	 *
	 * @param x			x position of the shape
	 * @param y			y position of the shape
	 * @param sides		number of sides (3=triangle, 4=square, etc)
	 * @param size		radius of the polygon (length to the corner)
	 * @param rotateDegree	(optional) starting rotation
	 */
	public function sides(x:Float, y:Float, sides:Int, size:Float, ?rotateDegree:Float) {
		// reset array
		this.arr = [];

		// store center point
		// this.cx = x;
		// this.cy = y;
		this.rx = x;
		this.ry = y;

		if (rotateDegree == null) {
			rotateDegree = 0;
		} else {
			rotateDegree = MathUtil.radians(rotateDegree);
		}

		// if (rotateDegree > 0) {
		// 	console.log(rotateDegree);
		// }

		// trace(x);
		// trace(y);
		// this.arr.push((x + size) * Math.cos(0));
		// this.arr.push((y + size) * Math.sin(0));
		for (i in 0...sides) {
			var _x = x + (size * Math.cos(rotateDegree + (i * (2 * Math.PI) / sides)));
			var _y = y + (size * Math.sin(rotateDegree + (i * (2 * Math.PI) / sides)));
			this.arr.push(_x);
			this.arr.push(_y);
		}
	}

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<Float> {
		return arr;
	}

	function set_arr(value:Array<Float>):Array<Float> {
		return arr = value;
	}

	function get_arrPoint():Array<Point> {
		return arrPoint;
	}

	function set_arrPoint(value:Array<Point>):Array<Point> {
		return arrPoint = value;
	}
}
