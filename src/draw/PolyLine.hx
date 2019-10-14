package draw;

class PolyLine extends Base implements IBase {
	public var type = 'PolyLine'; // base (get class name?)

	@:isVar public var arr(get, set):Array<Float>; // collection of points

	public function new(arr:Array<Float>) {
		this.arr = arr;
		super('polyline');
	}

	public function svg(?settings:Settings):String {
		if (desc != '') {
			xml.addChild(Xml.createComment('desc')); // still weird I need to do this
			xml.addChild(Xml.parse('<desc>${desc}</desc>'));
		}
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

	function get_arr():Array<Float> {
		return arr;
	}

	function set_arr(value:Array<Float>):Array<Float> {
		return arr = value;
	}
}
