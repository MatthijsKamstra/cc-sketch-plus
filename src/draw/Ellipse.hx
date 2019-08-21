package draw;

class Ellipse extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;
	@:isVar public var fill(get, set):String = '#909090';
	@:isVar public var stroke(get, set):String = '#000000';

	@:isVar public var ry(get, set):Int;
	@:isVar public var rx(get, set):Int;

	public var type = 'Ellipse'; // base (get class name?)

	public function new(x, y, rx, ry) {
		this.x = x;
		this.y = y;
		this.rx = rx;
		this.ry = ry;
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('ellipse');
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('rx', Std.string(this.rx));
		xml.set('ry', Std.string(this.ry));
		xml.set('stroke', Std.string(this.stroke));
		xml.set('fill', Std.string(this.fill));
		return xml.toString();
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

	function get_ry():Int {
		return ry;
	}

	function set_ry(value:Int):Int {
		return ry = value;
	}

	function get_rx():Int {
		return rx;
	}

	function set_rx(value:Int):Int {
		return rx = value;
	}

	function get_fill():String {
		return fill;
	}

	function set_fill(value:String):String {
		return fill = value;
	}

	function get_stroke():String {
		return stroke;
	}

	function set_stroke(value:String):String {
		return stroke = value;
	}
}
