package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

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
		// set everything to default values
		useDefaultsCanvas();

		// if (this.lineCap != null) {
		// 	ctx.lineCap = cast this.lineCap;
		// }
		// ctx.lineWidth = this.lineWeight;

		// // trace('fillColor : ' + this.fillColor);
		// // trace('fillOpacity: ' + this.fillOpacity);
		// // trace('strokeColor : ' + this.strokeColor);
		// // trace('strokeOpacity: ' + this.strokeOpacity);

		var _fillColor = ColorUtil.assumption(this.fillColor);
		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);

		var _strokeColor = ColorUtil.assumption(this.strokeColor);
		ctx.strokeStyle = ColorUtil.getColourObj(_strokeColor, this.strokeOpacity);

		if (this.dash != null) {
			ctx.setLineDash(this.dash);
		}

		// ctx.beginPath();

		// ctx.ellipse(this.x, this.y, this.rrx, this.rry, this.rotate, 0, 2 * Math.PI);

		// Draw the ellipse
		ctx.beginPath();
		ctx.ellipse(this.x, this.y, this.rrx, this.rry, MathUtil.radians(this.rotate), 0, 2 * Math.PI);

		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null && this.lineWeight != 0) {
			ctx.stroke();
		}
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
