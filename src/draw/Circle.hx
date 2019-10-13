package draw;

class Circle extends Base implements IBase {
	public var type = 'circle'; // base (get class name?)

	@:isVar public var radius(get, set):Float;

	public function new(x, y, radius) {
		this.x = x;
		this.y = y;
		this.radius = radius;
		super('circle');
	}

	public function noStroke() {
		this.linewidth = 0;
		this.stroke = 'transparant';
	}

	public function svg(?settings:Settings):String {
		// var xml = Xml.createElement('circle');
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('r', Std.string(this.radius));

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		if (this.linewidth != null)
			xml.set('stroke-width', Std.string(this.linewidth));

		return xml.toString();
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
	function get_radius():Float {
		return radius;
	}

	function set_radius(value:Float):Float {
		return radius = value;
	}
}
