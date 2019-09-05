package draw;

class Line extends Base implements IBase {
	@:isVar public var x2(get, set):Int;
	@:isVar public var y2(get, set):Int;

	// @:isVar public var stroke(get, set):String = '#000000';
	@:isVar public var lineCap(get, set):String = 'butt';

	@:isVar public var lineWeight(get, set):Int;

	public var type = 'Line'; // base (get class name?)

	public function new(x, y, x2, y2) {
		this.x = x;
		this.y = y;
		this.x2 = x2;
		this.y2 = y2;
		super('line');
	}

	public function svg(settings:Settings):String {
		xml.set('x1', Std.string(this.x));
		xml.set('y1', Std.string(this.y));
		xml.set('x2', Std.string(this.x2));
		xml.set('y2', Std.string(this.y2));
		xml.set('stroke', this.stroke);
		if (lineCap != 'butt')
			xml.set('stroke-linecap', this.lineCap);
		if (lineWeight != null)
			xml.set('stroke-width', Std.string(this.lineWeight));
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ getter/setter ____________________________________

	function get_x2():Int {
		return x2;
	}

	function set_x2(value:Int):Int {
		return x2 = value;
	}

	function get_y2():Int {
		return y2;
	}

	function set_y2(value:Int):Int {
		return y2 = value;
	}

	function get_lineCap():String {
		return lineCap;
	}

	function set_lineCap(value:String):String {
		return lineCap = value;
	}

	function get_lineWeight():Int {
		return lineWeight;
	}

	function set_lineWeight(value:Int):Int {
		return lineWeight = value;
	}
}
