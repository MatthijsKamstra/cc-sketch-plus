package sketcher.draw;

/**
 * https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths
 *
 * https://www.w3schools.com/graphics/svg_path.asp
 *
 *
 */
class Path extends Base implements IBase {
	public var dArray:Array<String> = [];

	public var type = 'Path'; // base (get class name?)

	public function new(x, y) {
		moveTo(x, y);
		super('path');
	}

	public function svg(?settings:Settings):String {
		var str = '';
		for (i in dArray) {
			str += i;
		}
		xml.set('d', str);
		return xml.toString();
	}

	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

	// ____________________________________ functions ____________________________________

	/**
	 * create a rectangular shape with an other rectangular shape punched out
	 * 	- sort of like a square donut
	 * 	- window
	 * 	- passe-partout
	 *
	 *
	 * @example:
	 * 				var _path = sketch.makePath(0, 0);
	 *				_path.window(100, 50, 400, 500, 225, 200, 150, 200);
	 *				_path.fillColor = getColourObj(PINK);
	 *
	 * <path d="M100,50V550H500V50ZM375,400H225V200H375Z" style="fill:#fff"/>
	 *
	 * @param  x       [description]
	 * @param  y       [description]
	 * @param  width   [description]
	 * @param  height  [description]
	 * @param  x2      [description]
	 * @param  y2      [description]
	 * @param  width2  [description]
	 * @param  height2 [description]
	 * @param          [description]
	 * @return         [description]
	 */
	public function window(x:Float, y:Float, width:Float, height:Float, x2:Float, y2:Float, width2:Float, height2:Float) {
		//  clear dArray
		dArray = [];
		this.id = 'passe-partout ${count}';
		// start drawing
		dArray.push('M${x},${y}'); // M100,50
		dArray.push('V${y + height}'); // V550
		dArray.push('H${x + width}'); // H500
		dArray.push('V${y}'); // V50
		dArray.push('Z'); // Z
		//
		dArray.push('M${x2 + width2},${y2 + height2}'); // M375,400
		dArray.push('H${x2}'); // H225
		dArray.push('V${y2}'); //  V200
		dArray.push('H${x2 + width2}'); // H375
		dArray.push('Z'); // Z
	}

	public function moveTo(x:Float, y:Float) {
		dArray.push('M${x}, ${y} ');
	}

	/**
	 * The most generic is the "Line To" command, called with L. L takes two parameters—x and y coordinates—and draws a line from the current position to a new position.
	 * @param x
	 * @param y
	 */
	public function lineTo(x, y) {
		dArray.push('L${x}, ${y} ');
	}

	/**
	 * There are two abbreviated forms for drawing horizontal and vertical lines. H draws a horizontal line, and V draws a vertical line. Both commands only take one argument since they only move in one direction.
	 * @param x
	 */
	public function horizontalLineTo(x) {
		dArray.push('H${x} ');
	}

	public function verticalLineTo(y) {
		dArray.push('V${y} ');
	}

	/**
	 * The cubic curve, C, is the slightly more complex curve. Cubic Beziers take in two control points for each point. Therefore, to create a cubic Bezier, you need to specify three sets of coordinates.
	 * @param x1	(x1,y1) is the control point for the start of your curve,
	 * @param y1	(x1,y1) is the control point for the start of your curve,
	 * @param x2	(x2,y2) is the control point for the end.
	 * @param y2	(x2,y2) is the control point for the end.
	 * @param x		The last set of coordinates here (x,y) are where you want the line to end.
	 * @param y		The last set of coordinates here (x,y) are where you want the line to end.
	 */
	public function curveto(x1:Float, y1:Float, x2:Float, y2:Float, x:Float, y:Float) {
		dArray.push('C${x1}, ${y1} ${x2}, ${y2} ${x}, ${y} ');
	}

	// S = smooth curveto
	// Q = quadratic Bézier curve
	// T = smooth quadratic Bézier curveto
	// A = elliptical Arc

	/**
	 * We can shorten the above path declaration a little bit by using the "Close Path" command, called with Z. This command draws a straight line from the current position back to the first point of the path. It is often placed at the end of a path node, although not always. There is no difference between the uppercase and lowercase command.
	 */
	public function closepath() {
		dArray.push('Z ');
	}

	// ____________________________________ getter/setter ____________________________________
}
