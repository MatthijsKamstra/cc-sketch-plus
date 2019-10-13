package draw;

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

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ functions ____________________________________

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
