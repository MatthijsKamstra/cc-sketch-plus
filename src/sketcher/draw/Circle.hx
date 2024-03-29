package sketcher.draw;

import sketcher.util.MathUtil;
import sketcher.util.ColorUtil;
import sketcher.AST.Point;

class Circle extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'circle'; // base (get class name?)

	@:isVar public var radius(get, set):Float;

	var cx:Float;
	var cy:Float;

	public var point_top_left:Point;
	public var point_top_right:Point;
	public var point_bottom_left:Point;
	public var point_bottom_right:Point;

	public function new(x, y, radius) {
		this.x = x;
		this.y = y;
		this.cx = x;
		this.cy = y;
		this.radius = radius;

		this.point_top_left = {x: this.cx - this.radius, y: this.cy - this.radius};
		this.point_top_right = {x: this.cx + this.radius, y: this.cy - this.radius};
		this.point_bottom_left = {x: this.cx - this.radius, y: this.cy + this.radius};
		this.point_bottom_right = {x: this.cx + this.radius, y: this.cy + this.radius};

		super('circle');
		// this.dash = []; // reset the dash for canvas?
	}

	public function svg(?settings:Settings):String {
		// var xml = Xml.createElement('circle');
		xml.set('cx', Std.string(this.x));
		xml.set('cy', Std.string(this.y));
		xml.set('r', Std.string(this.radius));

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		if (this.lineWeight != null)
			xml.set('stroke-width', Std.string(this.lineWeight));

		return xml.toString();
	}

	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		if (this.lineCap != null) {
			ctx.lineCap = cast this.lineCap;
		}
		ctx.lineWidth = this.lineWeight;

		var _fillColor = ColorUtil.assumption(this.fillColor);
		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);

		var _strokeColor = ColorUtil.assumption(this.strokeColor);
		ctx.strokeStyle = ColorUtil.getColourObj(_strokeColor, this.strokeOpacity);

		if (this.dash != null) {
			ctx.setLineDash(this.dash);
		}

		ctx.beginPath();

		// rotation & move...
		if (this.rotate != null) {
			// trace(this.x, this.y, this.rotate);
			ctx.save();

			ctx.translate(this.x, this.y);
			ctx.rotate(MathUtil.radians(this.rotate));

			if (this.move != null) {
				ctx.translate(this.move.x, this.move.y);
			}
			ctx.arc(0, 0, this.radius, 0, 2 * Math.PI);

			ctx.restore();
		}

		if (this.rotate == null) {
			ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
		}

		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null && this.lineWeight != 0) {
			ctx.stroke();
		}

		// ctx.fill();
		// ctx.stroke();

		if (this.rotate != null) {}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

	// ____________________________________ debug ____________________________________

	public function debug() {
		trace('${toString()}');
	}

	// ____________________________________ getter/setter ____________________________________
	function get_radius():Float {
		return radius;
	}

	function set_radius(value:Float):Float {
		return radius = value;
	}
}
