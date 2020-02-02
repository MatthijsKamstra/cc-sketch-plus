package sketcher.draw;

/**
 * @source
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/linearGradient
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/radialGradient
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/stop
 */
class Gradient extends draw.Base implements draw.IBase {
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
		stop0.set('offset', '0%');
		stop0.set('stop-color', '${this.color0}');
		var stop1 = Xml.createElement('stop');
		stop1.set('offset', '100%');
		stop1.set('stop-color', '${this.color1}');
		// var stop2 = Xml.createElement('stop');
		// stop2.set('offset', '50%');
		// stop2.set('stop-color', 'pink');

		xml.addChild(stop0);
		xml.addChild(stop1);
		// xml.addChild(stop2);

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
