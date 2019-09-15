package draw;

import cc.util.ColorUtil;

class Rectangle extends Base implements IBase {
	@:isVar public var width(get, set):Float;
	@:isVar public var height(get, set):Float;

	@:isVar public var radius(get, set):Int;

	public var type = 'rectangle'; // base (get class name?)

	var xpos:Float;
	var ypos:Float;

	public function new(x:Float, y:Float, width:Float, height:Float) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.xpos = this.x - (this.width / 2);
		this.ypos = this.y - (this.height / 2);
		super('rect');
	}

	public function noStroke() {
		this.linewidth = 0;
		this.stroke = 'transparant';
	}

	public function svg(settings:Settings):String {
		xml.set('x', Std.string(this.xpos));
		xml.set('y', Std.string(this.ypos));
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

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.fillStyle = this.fill;
		ctx.strokeStyle = this.stroke;
		ctx.lineWidth = this.linewidth;

		var color = ColorUtil.assumption(this.fill);
		ctx.fillStyle = ColorUtil.getColourObj(color, this.opacity);

		trace(ColorUtil.getColourObj(color, this.opacity));
		trace(color);
		trace(this.fill);

		ctx.beginPath();

		if (this.radius == null) {
			// normal rectangle
			ctx.rect(this.xpos, this.ypos, this.width, this.height);
		} else {
			// rectangle with radius
			var radius = {
				tl: this.radius,
				tr: this.radius,
				br: this.radius,
				bl: this.radius
			};
			ctx.moveTo(this.xpos + radius.tl, this.ypos);
			ctx.lineTo(this.xpos + this.width - radius.tr, this.ypos);
			ctx.quadraticCurveTo(this.xpos + this.width, this.ypos, this.xpos + this.width, this.ypos + radius.tr);
			ctx.lineTo(this.xpos + this.width, this.ypos + this.height - radius.br);
			ctx.quadraticCurveTo(this.xpos + this.width, this.ypos + this.height, this.xpos + this.width - radius.br, this.ypos + this.height);
			ctx.lineTo(this.xpos + radius.bl, this.ypos + this.height);
			ctx.quadraticCurveTo(this.xpos, this.ypos + this.height, this.xpos, this.ypos + this.height - radius.bl);
			ctx.lineTo(this.xpos, this.ypos + radius.tl);
			ctx.quadraticCurveTo(this.xpos, this.ypos, this.xpos + radius.tl, this.ypos);
			ctx.closePath();
		}

		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null && this.linewidth != 0) {
			ctx.stroke();
		}

		// ctx.fill();
		// ctx.stroke();
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
