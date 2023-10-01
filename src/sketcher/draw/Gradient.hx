package sketcher.draw;

#if js
import js.Browser.*;
import js.html.CanvasGradient;
#end

// quick gradients: https://digitalsynopsis.com/design/beautiful-color-ui-gradients-backgrounds/

/**
 * SVG: in svg you create a gradient and place it as a fill over an rectangle/circle/etc
 * CANVAS: in canvas you don't have that controle, so you create a rectantle and place the gradient over there
 */
/**
	// background gradient
	var gradient = sketch.makeGradient("#2193b0", "#6dd5ed");
	gradient.id = 'Sexy Blue';

	var gradient = sketch.makeGradient('#B993D6', '#8CA6DB');
	gradient.id = 'dirty-fog';

	// background
	var p = grid.array[0];
	var bg = sketch.makeRectangle(p.x, p.y, rectW, rectH);
	bg.id = "gradient sexy blue";
	// bg.fillColor = 'url(#dirty-fog)'; // works
	bg.fillGradientColor = 'Sexy Blue';
 */
/**
 * @source
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/linearGradient
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/radialGradient
 * 		https://developer.mozilla.org/en-US/docs/Web/SVG/Element/stop
 */
class Gradient extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'gradient'; // base (get class name?)

	var colors:Array<String> = [];
	var color0:String;
	var color1:String;

	var dir:GradientDir = LeftRight;

	#if js
	var canvasGradient:js.html.CanvasGradient;

	var gradientObj:GradientObj;
	#end

	/**
	 * quick way to create an gradient, needs more love
	 *
	 * @example
	 * new Gradient(['#2BC0E4', '#EAECC6'])
	 *
	 * @param colors		use and string array
	 * @param isLinear
	 */
	public function new(colors:Array<String>, isLinear:Bool = true) {
		this.colors = colors;

		super('linearGradient');
	}

	// TODO: add array with colors
	// TODO: more controle over the gradient, with `stop offset`

	/**
		<linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
		  <stop offset="0%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
		  <stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
		</linearGradient>
	 */
	public function svg(?settings:Settings):String {
		for (i in 0...colors.length) {
			var _colors = colors[i];
			// trace(_colors);
			var _percentage = Math.round((i / (colors.length - 1)) * 100);
			var stop = Xml.createElement('stop');
			stop.set('offset', '${_percentage}%');
			stop.set('stop-color', '${_colors}');
			xml.addChild(stop);
			// warn(stop);
		}

		// // xml.set('id', 'test-gradient');
		// var stop0 = Xml.createElement('stop');
		// stop0.set('offset', '0%');
		// stop0.set('stop-color', '${this.color0}');
		// var stop1 = Xml.createElement('stop');
		// stop1.set('offset', '100%');
		// stop1.set('stop-color', '${this.color1}');
		// // var stop2 = Xml.createElement('stop');
		// // stop2.set('offset', '50%');
		// // stop2.set('stop-color', 'pink');

		// xml.addChild(stop0);
		// xml.addChild(stop1);
		// // xml.addChild(stop2);

		// // if (this.stroke != null)
		// // 	xml.set('stroke', this.stroke);

		// // if (lineWeight != null)
		// // 	xml.set('stroke-width', Std.string(this.lineWeight));

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
	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// if (!ISWARN) {
		// 	console.warn('Gradient doens\'t work the same as svg, use with care');
		// 	ISWARN = true;
		// }

		var w = ctx.canvas.width;
		var h = ctx.canvas.height;
		var grd:CanvasGradient;

		switch (dir) {
			case LeftRight, LR:
				grd = ctx.createLinearGradient(0, 0, w, 0);
			case RightLeft, RL:
				grd = ctx.createLinearGradient(h, 0, 0, 0);
			case TopBottom, TB:
				grd = ctx.createLinearGradient(0, 0, 0, h);
			case BottomTop, BT:
				grd = ctx.createLinearGradient(0, w, 0, 0);
			case LeftTopRightBottom, TopLeftBottomRight:
				grd = ctx.createLinearGradient(0, 0, w, h);
			case LeftBottomTopRight, BottomLeftRightTop:
				grd = ctx.createLinearGradient(0, h, w, 0);
			case RightBottomLeftTop, BottomRightTopLeft:
				grd = ctx.createLinearGradient(h, w, 0, 0);
			case TopRightLeftBottom, RightTopBottomLeft:
				grd = ctx.createLinearGradient(h, 0, 0, h);
			default:
				trace("case '" + dir + "': trace ('" + dir + "');");
				grd = ctx.createLinearGradient(0, 0, w, 0);
		}

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

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

	// ____________________________________ misc ____________________________________

	/**
	 * var gradient = sketch.makeGradient(getColourObj(_color0), getColourObj(_color1));
	 * gradient.setGradientDirection(LeftTopRightBottom);
	 *
	 * @param dir
	 */
	public function setGradientDirection(dir:GradientDir) {
		this.dir = dir;
	}
}

enum GradientDir {
	LeftRight;
	LR;
	RightLeft;
	RL;
	TopBottom;
	TB;
	BottomTop;
	BT;
	//
	LeftTopRightBottom;
	TopLeftBottomRight; // syntatic sugar
	LeftBottomTopRight;
	BottomLeftRightTop; // syntatic sugar
	//
	RightBottomLeftTop;
	BottomRightTopLeft; // syntatic sugar
	TopRightLeftBottom;
	RightTopBottomLeft; // syntatic sugar
}

#if js
typedef GradientObj = {
	var id:String;
	var canvasGradient:js.html.CanvasGradient;
}
#end
