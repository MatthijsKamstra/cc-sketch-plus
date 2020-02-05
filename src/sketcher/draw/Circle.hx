package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class Circle extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'circle'; // base (get class name?)

	@:isVar public var radius(get, set):Float;

	public function new(x, y, radius) {
		this.x = x;
		this.y = y;
		this.radius = radius;
		super('circle');
		// this.dash = []; // reset the dash for canvas?
	}

	public function noStroke() {
		this.lineWeight = 0;
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

		if (this.lineWeight != null)
			xml.set('stroke-width', Std.string(this.lineWeight));

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		if (this.lineCap != null) {
			ctx.lineCap = cast this.lineCap;
		}
		ctx.lineWidth = this.lineWeight;

		// trace('fillColor : ' + this.fillColor);
		// trace('fillOpacity: ' + this.fillOpacity);
		// trace('strokeColor : ' + this.strokeColor);
		// trace('strokeOpacity: ' + this.strokeOpacity);

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
