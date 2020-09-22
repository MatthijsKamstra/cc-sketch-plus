package sketcher.draw;

import js.Browser.*;
import js.html.webgl.RenderingContext;
import sketcher.AST.Point;
import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class Rectangle extends Base implements IBase {
	public static var ISWARN:Bool;

	@:isVar public var width(get, set):Float;
	@:isVar public var height(get, set):Float;

	@:isVar public var radius(get, set):Int;

	public var type = 'rectangle'; // base (get class name?)

	var cx:Float;
	var cy:Float;
	var isCenter:Bool;

	public var point_top_left:Point;
	public var point_top_right:Point;
	public var point_bottom_left:Point;
	public var point_bottom_right:Point;

	public function new(x:Float, y:Float, width:Float, height:Float, ?isCenter:Bool = true) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.cx = this.x - (this.width / 2);
		this.cy = this.y - (this.height / 2);

		this.isCenter = isCenter;
		if (!isCenter) {
			this.cx = this.x;
			this.cy = this.y;
		}

		this.point_top_left = {x: this.cx, y: this.cy};
		this.point_top_right = {x: this.cx + this.width, y: this.cy};
		this.point_bottom_left = {x: this.cx, y: this.cy + this.height};
		this.point_bottom_right = {x: this.cx + this.width, y: this.cy + this.height};

		super('rect');
	}

	public function svg(?settings:Settings):String {
		xml.set('x', Std.string(this.cx));
		xml.set('y', Std.string(this.cy));
		xml.set('width', Std.string(this.width));
		xml.set('height', Std.string(this.height));

		if (radius != null) {
			xml.set('rx', Std.string(this.radius));
			xml.set('ry', Std.string(this.radius));
		}

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		return xml.toString();
	}

	public function useCanvasShadow(ctx:js.html.CanvasRenderingContext2D) {
		if (this.shadowColor != null) {
			ctx.shadowColor = this.shadowColor;
			ctx.shadowBlur = this.shadowBlur;
			ctx.shadowOffsetX = this.shadowOffsetX;
			ctx.shadowOffsetY = this.shadowOffsetY;
		}
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		// useCanvasShadow(ctx);

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

		// console.group('${this.id} - isCenter: ${isCenter}');

		// // trace(this.rotate, this.move);
		// console.log('#0 - start');

		ctx.beginPath();
		// rotation is set & move is not (still null)...
		if (this.rotate != null && this.move == null) {
			// console.log('#1 - rotate');

			// trace(this.x, this.y, this.rotate);

			// trace('rotate but not move');

			ctx.save();

			// ctx.translate(this.cx, this.cy);
			ctx.translate(this.x, this.y);
			ctx.rotate(MathUtil.radians(this.rotate));

			// ctx.arc(0, 0, 10, 0, 2 * Math.PI);
			// ctx.translate(-this.cx, -this.cy);

			// if (this.move != null) {
			// 	ctx.translate(this.move.x, this.move.y);
			// }

			// ctx.rect(0, 0, this.width, this.height);
			ctx.rect(-(this.width / 2), -(this.height / 2), this.width, this.height);

			// console.debug('$id, x: ${x}, y: ${y}, width: ${width}, height: ${height}, cx: ${cx}, cy: ${cy}, isCenter: ${isCenter}');
			// console.debug('$id, x: ${x}, y: ${y}, width: ${width}, height: ${height}, cx: ${cx}, cy: ${cy}, isCenter: ${isCenter}');
			// buildCanvasShape(ctx);

			ctx.restore();
		}

		// move is set & rotation is not (still null)...
		if (this.move != null && this.rotate == null) {
			// console.log('#2 - move');
			// trace('move but not rotate');
			ctx.save();
			ctx.translate(this.cx, this.cy);

			ctx.translate(this.move.x, this.move.y);

			ctx.rect(0, 0, this.width, this.height);

			ctx.restore();
		}

		if (this.rotate == null && this.move == null) {
			// console.log('#3 - default');
			buildCanvasShape(ctx);
		}

		/**
			ctx.translate(x, y);
			ctx.rotate(MathUtil.radians(180));
			fillTriangle(ctx, 0, 0 - sz, 0 + sz, 0 + sz / 2, 0 - sz, 0 + sz / 2);
			ctx.rotate(MathUtil.radians(-180));
			ctx.translate(-x, -y);
		 */

		// console.log('#4 - end');

		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null && this.lineWeight != 0) {
			ctx.stroke();
		}

		// ctx.fill();
		// ctx.stroke();

		// console.groupEnd();

		// ctx.shadowColor = "transparent";
	}

	private function buildCanvasShape(ctx:js.html.CanvasRenderingContext2D) {
		if (this.radius == null) {
			// normal rectangle
			ctx.rect(this.cx, this.cy, this.width, this.height);
		} else {
			// rectangle with radius
			var radius = {
				tl: this.radius,
				tr: this.radius,
				br: this.radius,
				bl: this.radius
			};
			ctx.moveTo(this.cx + radius.tl, this.cy);
			ctx.lineTo(this.cx + this.width - radius.tr, this.cy);
			ctx.quadraticCurveTo(this.cx + this.width, this.cy, this.cx + this.width, this.cy + radius.tr);
			ctx.lineTo(this.cx + this.width, this.cy + this.height - radius.br);
			ctx.quadraticCurveTo(this.cx + this.width, this.cy + this.height, this.cx + this.width - radius.br, this.cy + this.height);
			ctx.lineTo(this.cx + radius.bl, this.cy + this.height);
			ctx.quadraticCurveTo(this.cx, this.cy + this.height, this.cx, this.cy + this.height - radius.bl);
			ctx.lineTo(this.cx, this.cy + radius.tl);
			ctx.quadraticCurveTo(this.cx, this.cy, this.cx + radius.tl, this.cy);
			ctx.closePath();
		}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {
		if (!ISWARN) {
			console.warn('webgl is not implemented yet');
			ISWARN = true;
		}

		var c = '#ff3333';

		var rgba = ColorUtil.assumption(c);
		// trace(rgba);
		// Set clear color to black, fully opaque
		// gl.clearColor(rgba.r, rgba.g, rgba.b, rgba.a);
		// Clear the color buffer with specified clear color
		// gl.clear(gl.COLOR_BUFFER_BIT);
		// gl.clear(0);

		gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
		// Set the clear color to darkish green.
		gl.clearColor(rgba.r / 255, rgba.g / 255, rgba.b / 255, rgba.a);
		// gl.clearColor(0.0, 0.5, 0.0, 1.0);
		// Clear the context with the newly set color. This is
		// the function call that actually does the drawing.
		gl.clear(RenderingContext.COLOR_BUFFER_BIT);
	}

	// ____________________________________ getter/setter ____________________________________
	function get_radius():Int {
		return radius;
	}

	function set_radius(value:Int):Int {
		return radius = value;
	}

	function get_width():Float {
		return width;
	}

	function set_width(value:Float):Float {
		return width = value;
	}

	function get_height():Float {
		return height;
	}

	function set_height(value:Float):Float {
		return height = value;
	}
}
