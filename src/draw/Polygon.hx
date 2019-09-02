package draw;

class Polygon extends Base implements IBase {
	public var type = 'Polygon'; // base (get class name?)

	@:isVar public var arr(get, set):Array<Int>; // collection of points

	// @:isVar public var translate(get, set):Array<Int>;

	public function new(arr:Array<Int>) {
		this.arr = arr;
		xml = Xml.createElement('polygon');
	}

	/**
		<!-- Example of a polygon with the default fill -->
		<polygon points="0,100 50,25 50,75 100,0" />
		<!-- Example of the same polygon shape with stroke and no fill -->
		<polygon points="100,100 150,25 150,75 200,0" fill="none" stroke="black" />
	 */
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

		// if (this.translate != null)
		// 	xml.set('transform', 'translate(${this.translate[0]},${this.translate[1]})');
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ hmmmm ____________________________________
	// transform="translate(20,2.5) rotate(10)">
	// public function setTranslate(x, y) {
	// 	this.translate = [x, y];
	// }

	/**
	 * position the shape by offset x and y
	 * usefull when having a polygon but the values need to repostioned
	 *
	 * @param x position in x direction
	 * @param y position in y dir
	 */
	// public function position(x, y) {
	// 	this.translate = [x, y];
	// }
	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<Int> {
		return arr;
	}

	function set_arr(value:Array<Int>):Array<Int> {
		return arr = value;
	}

	// function get_translate():Array<Int> {
	// 	return translate;
	// }
	// function set_translate(value:Array<Int>):Array<Int> {
	// 	return translate = value;
	// }
}
