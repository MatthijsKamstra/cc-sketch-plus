package;

class _IBaseTemplate extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;

	public var type = '_IBaseTemplate'; // base (get class name?)

	public function new(x, y) {
		this.x = x;
		this.y = y;
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('circle');
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));

		return xml.toString();
		/*
			return '<circle
			cx="${this.x}"
			cy="${this.y}"
			r="${this.radius}"
			stroke="${this.stroke}"
			fill="${this.fill}"
			stroke-width="${this.linewidth}" />';
		 */
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ getter/setter ____________________________________

	function get_y():Int {
		return y;
	}

	function set_y(value:Int):Int {
		return y = value;
	}

	function get_x():Int {
		return x;
	}

	function set_x(value:Int):Int {
		return x = value;
	}
}
