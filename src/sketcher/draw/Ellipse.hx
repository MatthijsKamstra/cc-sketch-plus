package sketcher.draw;

class Ellipse extends Base implements IBase {
	@:isVar public var ry(get, set):Float;
	@:isVar public var rx(get, set):Float;

	public var type = 'Ellipse'; // base (get class name?)

	public function new(x, y, rx, ry) {
		this.x = x;
		this.y = y;
		this.rx = rx;
		this.ry = ry;
		super('ellipse');
	}

	public function svg(?settings:Settings):String {
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('rx', Std.string(this.rx));
		xml.set('ry', Std.string(this.ry));

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

	function get_ry():Float {
		return ry;
	}

	function set_ry(value:Float):Float {
		return ry = value;
	}

	function get_rx():Float {
		return rx;
	}

	function set_rx(value:Float):Float {
		return rx = value;
	}
}
