package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.AST.Point;
import sketcher.draw.AST.LineCap;

/**
 * The <polyline> element is used to create any shape that consists of only straight lines (that is connected at several points):
 * @source: 	https://www.w3schools.com/graphics/svg_polyline.asp
 */
class PolyLine extends Base implements IBase {
	public var type = 'PolyLine'; // base (get class name?)

	// @:isVar public var lineCap(get, set):LineCap;
	@:isVar public var arr(get, set):Array<Float>; // collection of points

	public function new(arr:Array<Float>) {
		this.arr = arr;
		super('polyline');
	}

	public function svg(?settings:Settings):String {
		if (desc != '') {
			// xml.addChild(Xml.createComment('desc')); // still weird I need to do this
			xml.addChild(Xml.parse('<desc>${desc}</desc>'));
		}
		var str = '';
		for (i in 0...this.arr.length) {
			var value = this.arr[i];
			str += '${value} ';
		}
		xml.set('points', str);

		if (this.getTransform() != '') {
			trace(this.getTransform());
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

		var _fillColor = ColorUtil.assumption(this.fillColor);
		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);

		var _strokeColor = ColorUtil.assumption(this.strokeColor);
		ctx.strokeStyle = ColorUtil.getColourObj(_strokeColor, this.strokeOpacity);

		if (this.dash != null) {
			ctx.setLineDash(this.dash);
		}

		ctx.beginPath();

		var _pointArray = convertArr();
		// trace(this.pointArray);
		// trace('----');
		// trace(_pointArray);

		for (i in 0..._pointArray.length) {
			var p = _pointArray[i];
			if (i == 0) {
				ctx.moveTo(p.x, p.y);
			} else {
				ctx.lineTo(p.x, p.y);
			}
		}

		ctx.stroke();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

	function convertArr():Array<Point> {
		var _pointArray = [];
		for (i in 0...this.arr.length) {
			if (i % 2 == 0) {
				var x = this.arr[i];
				var y = this.arr[i + 1];
				_pointArray.push({x: x, y: y});
			}
		}
		return _pointArray;
	}

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<Float> {
		return arr;
	}

	function set_arr(value:Array<Float>):Array<Float> {
		return arr = value;
	}
}
