package draw;

import cc.AST.Point;

class Polygon extends draw.Base implements IBase {
	public var type = 'Polygon'; // base (get class name?)

	@:isVar public var arr(get, set):Array<Float>; // collection of points

	public function new(arr:Array<Float>) {
		this.arr = arr;
		super('polygon');
	}

	public function svg(?settings:Settings):String {
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
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

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
	 */
	public function sides(x:Float, y:Float, sides:Int, size:Float) {
		// reset array
		this.arr = [];

		// trace(x);
		// trace(y);
		// this.arr.push((x + size) * Math.cos(0));
		// this.arr.push((y + size) * Math.sin(0));
		for (i in 0...sides) {
			var _x = x + (size * Math.cos(i * (2 * Math.PI) / sides));
			var _y = y + (size * Math.sin(i * (2 * Math.PI) / sides));
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
}
