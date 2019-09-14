package draw;

class Polygon extends Base implements IBase {
	public var type = 'Polygon'; // base (get class name?)

	@:isVar public var arr(get, set):Array<Int>; // collection of points

	public function new(arr:Array<Int>) {
		this.arr = arr;
		super('polygon');
	}

	public function svg(settings:Settings):String {
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

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<Int> {
		return arr;
	}

	function set_arr(value:Array<Int>):Array<Int> {
		return arr = value;
	}
}
