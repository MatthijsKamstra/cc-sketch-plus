package sketcher.draw;

import js.Browser.*;

/**
 * SVG: in svg you create a gradient and place it as a fill over an rectangle/circle/etc
 * CANVAS: in canvas you don't have that controle, so you create a rectantle and place the gradient over there
 */
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

	var canvasGradient:js.html.CanvasGradient;
	var gradientObj:GradientObj;

	/**
	 * [Description]
	 * @param color0
	 * @param color1
	 * @param isLinear
	 */
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

	/**
	 * 	currently the svg way of creating gradients doesn't work with canvas
	 *
	 * @example:
	 *			if (settings.type.toLowerCase() == 'canvas') {
	 *				var gradient = sketch.makeGradient('#B993D6', '#8CA6DB');
	 *			}
	 *
	 * @param ctx
	 */
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		console.warn('Gradient doens\'t work the same as svg, use with care');

		var w = ctx.canvas.width;
		var h = ctx.canvas.height;
		var grd = ctx.createLinearGradient(0, 0, w, 0);
		grd.addColorStop(0, '${this.color0}');
		grd.addColorStop(1, '${this.color1}');

		// [mck] probably use this to get this var in combination with rect?
		canvasGradient = grd;
		gradientObj = {
			id: this.id,
			canvasGradient: canvasGradient
		}

		ctx.fillStyle = grd;
		ctx.fillRect(0, 0, w, h);
	}
}

typedef GradientObj = {
	var id:String;
	var canvasGradient:js.html.CanvasGradient;
}
