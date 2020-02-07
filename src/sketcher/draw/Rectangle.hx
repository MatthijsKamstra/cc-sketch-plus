package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.AST.Point;

class Rectangle extends Base implements IBase {
	@:isVar public var width(get, set):Float;
	@:isVar public var height(get, set):Float;

	@:isVar public var radius(get, set):Int;

	public var type = 'rectangle'; // base (get class name?)

	var xpos:Float;
	var ypos:Float;
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
		this.xpos = this.x - (this.width / 2);
		this.ypos = this.y - (this.height / 2);

		this.isCenter = isCenter;
		if (!isCenter) {
			this.xpos = this.x;
			this.ypos = this.y;
		}

		this.point_top_left = {x: this.xpos, y: this.ypos};
		this.point_top_right = {x: this.xpos + this.width, y: this.ypos};
		this.point_bottom_left = {x: this.xpos, y: this.ypos + this.height};
		this.point_bottom_right = {x: this.xpos + this.width, y: this.ypos + this.height};

		super('rect');
	}

	public function noStroke() {
		this.lineWeight = 0;
		this.strokeOpacity = 0;
	}

	public function svg(?settings:Settings):String {
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
		if (this.stroke != null && this.lineWeight != 0) {
			ctx.stroke();
		}

		// ctx.fill();
		// ctx.stroke();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

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
