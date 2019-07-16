package;

import cc.util.ColorUtil;

class Rectangle extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;
	@:isVar public var width(get, set):Int;
	@:isVar public var height(get, set):Int;
	@:isVar public var fill(get, set):String = '#909090';
	@:isVar public var stroke(get, set):String = '#000000';
	@:isVar public var linewidth(get, set):Int = 1;
	@:isVar public var opacity(get, set):Float = 1;
	@:isVar public var radius(get, set):Int;

	public var type = 'rectangle'; // base (get class name?)

	var xpos:Float;
	var ypos:Float;

	public function new(x, y, width, height) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.xpos = this.x - (this.width / 2);
		this.ypos = this.y - (this.height / 2);
	}

	public function noStroke() {
		this.linewidth = 0;
		this.stroke = 'transparant';
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('rect');
		xml.set('x', Std.string(this.xpos));
		xml.set('y', Std.string(this.ypos));
		xml.set('width', Std.string(this.width));
		xml.set('height', Std.string(this.height));
		xml.set('stroke', Std.string(this.stroke));
		xml.set('fill', Std.string(this.fill));
		xml.set('stroke-width', Std.string(this.linewidth));
		xml.set('fill-opacity', Std.string(this.opacity));
		xml.set('stroke-opacity', Std.string(this.opacity));
		if (radius != null)
			xml.set('rx', Std.string(this.radius));
		if (radius != null)
			xml.set('ry', Std.string(this.radius));

		return xml.toString();

		// trace(xml.toString());
		// var svg = '';
		// svg += '<rect x="${this.xpos}" y="${this.ypos}" width="${this.width}"
		// height="${this.height}" stroke="${this.stroke}" fill="${this.fill}"
		// stroke-width="${this.linewidth}" fill-opacity="${this.opacity}" stroke-opacity="${this.opacity}"/>';

		// return svg;
		// return '<circle cx="${this.x}" cy="${this.y}" r="${this.radius}" stroke="${this.stroke}" fill="${this.fill}" stroke-width="${this.linewidth}"/>';
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

		ctx.rect(this.xpos, this.ypos, this.width, this.height);
		/*
			_width = Math.abs(_width);
			_height = Math.abs(_height);
			_x = _x - _width / 2;
			_y = _y - _height / 2;
			// if (_width < radius) radius = _width;
			var radius = {
				tl: _radius,
				tr: _radius,
				br: _radius,
				bl: _radius
			};
			ctx.beginPath();
			ctx.moveTo(_x + radius.tl, _y);
			ctx.lineTo(_x + _width - radius.tr, _y);
			ctx.quadraticCurveTo(_x + _width, _y, _x + _width, _y + radius.tr);
			ctx.lineTo(_x + _width, _y + _height - radius.br);
			ctx.quadraticCurveTo(_x + _width, _y + _height, _x + _width - radius.br, _y + _height);
			ctx.lineTo(_x + radius.bl, _y + _height);
			ctx.quadraticCurveTo(_x, _y + _height, _x, _y + _height - radius.bl);
			ctx.lineTo(_x, _y + radius.tl);
			ctx.quadraticCurveTo(_x, _y, _x + radius.tl, _y);
			ctx.closePath();
		 */
		if (this.fill != null) {
			ctx.fill();
		}
		if (this.stroke != null) {
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

	function get_width():Int {
		return width;
	}

	function set_width(value:Int):Int {
		return width = value;
	}

	function get_height():Int {
		return height;
	}

	function set_height(value:Int):Int {
		return height = value;
	}
}
