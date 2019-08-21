package draw;

class Circle extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;
	@:isVar public var radius(get, set):Int;
	@:isVar public var fill(get, set):String = '#909090';
	@:isVar public var stroke(get, set):String = '#000000';
	@:isVar public var linewidth(get, set):Int = 1;
	@:isVar public var opacity(get, set):Float; // should between 0 and 1

	public var type = 'circle'; // base (get class name?)

	public function new(x, y, radius) {
		this.x = x;
		this.y = y;
		this.radius = radius;
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('circle');
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('r', Std.string(this.radius));
		xml.set('fill', Std.string(this.fill));
		xml.set('stroke', Std.string(this.stroke));
		xml.set('stroke-width', Std.string(this.linewidth));
		if (opacity != null) {
			xml.set('fill-opacity', Std.string(this.opacity));
			xml.set('stroke-opacity', Std.string(this.opacity));
		}

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
		ctx.fillStyle = this.fill;
		ctx.strokeStyle = this.stroke;
		ctx.lineWidth = this.linewidth;
		ctx.beginPath();
		ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ getter/setter ____________________________________
	function get_radius():Int {
		return radius;
	}

	function set_radius(value:Int):Int {
		return radius = value;
	}

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

	function get_linewidth():Int {
		return linewidth;
	}

	function set_linewidth(value:Int):Int {
		return linewidth = value;
	}

	function get_opacity():Float {
		return opacity;
	}

	function set_opacity(value:Float):Float {
		return opacity = value;
	}
}
