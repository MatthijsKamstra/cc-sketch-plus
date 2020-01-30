package draw;

class Gradient extends draw.Base implements IBase {
	public var type = 'gradient'; // base (get class name?)

	var color0:String;
	var color1:String;

	public function new(color0:String, color1:String, isLinear:Bool = true) {
		this.color0 = color0;
		this.color1 = color1;

		super('linearGradient');
	}

	/**
		<linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
		  <stop offset="0%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
		  <stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
		</linearGradient>
	 */
	public function svg(?settings:Settings):String {
		// xml.set('id', 'test-gradient');
		var stop0 = Xml.createElement('stop');
		stop0.set('offset', '5%');
		stop0.set('stop-color', '${this.color0}');
		var stop1 = Xml.createElement('stop');
		stop1.set('offset', '95%');
		stop1.set('stop-color', '${this.color1}');
		// xml.set('y1', Std.string(this.y));

		xml.addChild(stop0);
		xml.addChild(stop1);

		// if (this.stroke != null)
		// 	xml.set('stroke', this.stroke);

		// if (lineWeight != null)
		// 	xml.set('stroke-width', Std.string(this.lineWeight));

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}
}
