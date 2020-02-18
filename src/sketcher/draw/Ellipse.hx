package sketcher.draw;

class Ellipse extends Base implements IBase {
	@:isVar public var rry(get, set):Float;
	@:isVar public var rrx(get, set):Float;

	public var type = 'Ellipse'; // base (get class name?)

	public function new(x, y, rx, ry) {
		this.x = x;
		this.y = y;
		this.rrx = rx;
		this.rry = ry;
		super('ellipse');
	}

	public function svg(?settings:Settings):String {
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('rx', Std.string(this.rrx));
		xml.set('ry', Std.string(this.rry));

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

	public function gl(gl:js.html.webgl.RenderingContext) {}

	// ____________________________________ getter/setter ____________________________________

	function get_rry():Float {
		return rry;
	}

	function set_rry(value:Float):Float {
		return rry = value;
	}

	function get_rrx():Float {
		return rrx;
	}

	function set_rrx(value:Float):Float {
		return rrx = value;
	}
}
