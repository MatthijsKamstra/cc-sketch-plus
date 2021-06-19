package sketcher.draw;

#if js
import js.Browser.*;
#end
import sketcher.AST.Point;
import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class Button extends Base implements IBase {
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

	// for mouse stuff
	#if js
	var rect:js.html.DOMRect;
	#end
	var scale:Float;

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

	#if js
	public function useCanvasShadow(ctx:js.html.CanvasRenderingContext2D) {
		if (this.shadowColor != null) {
			ctx.shadowColor = this.shadowColor;
			ctx.shadowBlur = this.shadowBlur;
			ctx.shadowOffsetX = this.shadowOffsetX;
			ctx.shadowOffsetY = this.shadowOffsetY;
		}
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// use for mouse
		rect = Sketcher.ctx.canvas.getBoundingClientRect();
		scale = rect.width / Globals.w;

		// console.log(rect);

		// console.log(Sketcher.ctx.canvas.width);
		// console.log(Globals.w);

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

			ctx.arc(0, 0, 10, 0, 2 * Math.PI);
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

		// The x and y offset of the canvas from the edge of the page

		Sketcher.ctx.canvas.addEventListener('mousedown', (e:js.html.MouseEvent) -> {
			// trace('mouse down');
			Globals.mouseX = e.clientX - rect.left;
			Globals.mouseY = e.clientY - rect.top;

			// trace(Globals.mouseX, Globals.mouseY);

			if (isMouseOver()) {
				trace('click');
			}
			// this.point_top_left = {x: this.cx, y: this.cy};

			// this.point_top_right = {x: this.cx + this.width, y: this.cy};
			// this.point_bottom_left = {x: this.cx, y: this.cy + this.height};
			// this.point_bottom_right = {x: this.cx + this.width, y: this.cy + this.height};

			Globals.isMouseDown = true;
		});

		Sketcher.ctx.canvas.addEventListener('mousemove', e -> {
			Globals.mouseX = e.clientX - rect.left;
			Globals.mouseY = e.clientY - rect.top;

			if (isMouseOver()) {
				// trace('change'); // cursor: pointer;{cursor: default;}

				Sketcher.ctx.canvas.style.cursor = 'pointer';
			} else {
				Sketcher.ctx.canvas.style.cursor = 'default';
			}

			// if (Globals.isMouseDown == true) {
			// 	// drawLine(context, x, y, e.clientX - rect.left, e.clientY - rect.top);
			// 	// x = e.clientX - rect.left;
			// 	// y = e.clientY - rect.top;
			// 	trace('mouse move ');
			// }
		});

		window.addEventListener('mouseup', e -> {
			if (Globals.isMouseDown == true) {
				// drawLine(context, x, y, e.clientX - rect.left, e.clientY - rect.top);
				// x = 0;
				// y = 0;
				// trace('mouse up');
				Globals.isMouseDown = false;
			}
		});
	}

	function isMouseOver():Bool {
		if (Globals.mouseX >= this.point_top_left.x * scale
			&& Globals.mouseX <= this.point_bottom_right.x * scale
			&& Globals.mouseY >= this.point_top_left.y * scale
			&& Globals.mouseY <= this.point_bottom_right.y * scale) {
			return true;
		} else {
			return false;
		}
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

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

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
