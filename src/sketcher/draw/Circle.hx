package sketcher.draw;

import cc.util.ColorUtil;

class Circle extends draw.Base implements draw.IBase {
	public var type = 'circle'; // base (get class name?)

	@:isVar public var radius(get, set):Float;

	public function new(x, y, radius) {
		this.x = x;
		this.y = y;
		this.radius = radius;
		super('circle');
		this.dash = []; // reset the dash for canvas?
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
		ctx.lineWidth = this.lineWeight;
		if (this.fillColor == null) {
			this.fillColor = '#000000';
		}
		if (this.strokeColor == null) {
			this.strokeColor = '#000000';
		}
		if (this.fillOpacity == null) {
			this.fillOpacity = 1;
		}
		if (this.strokeOpacity == null) {
			this.strokeOpacity = 1;
		}
		if (this.lineCap != null) {
			ctx.lineCap = cast this.lineCap;
		}
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
		ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
		ctx.fill();
		ctx.stroke();
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
