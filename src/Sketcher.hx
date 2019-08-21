package;

import js.Browser.*;

class Sketcher {
	var settings:Settings;
	// var paper:Dynamic;
	var element:js.html.Element;
	var baseArray:Array<IBase> = [];
	var svg:String;
	var canvas:js.html.CanvasElement;

	public static var ctx:js.html.CanvasRenderingContext2D;

	public function new(settings:Settings) {
		this.settings = settings;
	}

	// ____________________________________ util to append ____________________________________

	public function appendTo(element:js.html.Element):Sketcher {
		this.element = element;
		if (settings.type == 'canvas') {
			canvas = document.createCanvasElement();
			canvas.width = settings.width;
			canvas.height = settings.height;
			canvas.id = 'canvas';
			ctx = canvas.getContext2d();
			element.appendChild(canvas);
		}
		return this;
	}

	// ____________________________________ make something ____________________________________

	public function makeText(str:String, ?x, ?y):Text {
		var shape = new Text(str, x, y);
		baseArray.push(shape);
		return shape;
	}

	public function makeCircle(x, y, radius):Circle {
		var shape = new Circle(x, y, radius);
		baseArray.push(shape);
		return shape;
	}

	public function makeRectangle(x, y, width, height):Rectangle {
		var shape = new Rectangle(x, y, width, height);
		baseArray.push(shape);
		return shape;
	}

	public function makeRoundedRectangle(x, y, width, height, radius):Rectangle {
		var shape = new Rectangle(x, y, width, height);
		shape.radius = radius;
		baseArray.push(shape);
		return shape;
	}

	public function makeLine(x1, y1, x2, y2):Line {
		var shape = new Line(x1, y1, x2, y2);
		baseArray.push(shape);
		return shape;
	}

	public function makeEllipse(x, y, width, height):Void {
		// your code
		console.warn('this function is not working');
	}

	public function makePolygon(sides):Polygon {
		var shape = new Polygon(sides);
		baseArray.push(shape);
		return shape;
	}

	/**
	 * wip!!!!
	 * @param one
	 * @param two
	 * @return Group
	 */
	public function makeGroup(one, two):Group {
		var shape = new Group(one, two);
		baseArray.push(shape);
		return shape;
	}

	public function makeX(x, y):Line {
		var cx = x;
		var cy = y;
		var r = 5;

		var lineX = new Line(cx - r, cy, cx + r, cy);
		lineX.stroke = 'red';
		baseArray.push(lineX);
		var lineY = new Line(cx, cy - r, cx, cy + r);
		lineY.stroke = 'red';
		baseArray.push(lineY);

		// var group = two.makeGroup(circle, rect);

		return lineX;
	}

	// ____________________________________ update ____________________________________

	public function update() {
		// trace('WIP update');
		if (element == null) {
			// make sure the element exists
			console.warn('element doesn\'t exist in DOM (${element})');
			return;
		}
		trace('type:${settings.type}, id:${element.id}');
		if (settings.type == 'svg') {
			// [mck] TODO change string into XML!!!
			var paper = '<?xml version="1.0" standalone="no"?><svg width="${settings.width}" height="${settings.height}" version="1.1" xmlns="http://www.w3.org/2000/svg">';
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				if (base.id == null)
					base.id = base.getName();
				var draw = base.svg(settings);
				// trace(base.toString());
				// trace(draw);
				paper += draw;
			}
			paper += '</svg>';
			element.innerHTML = paper;
		} else {
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				trace(base.type);
				base.ctx(ctx);
			}
		}
	}

	// [mck] TODO create settings AST to have possible object send as well?
	public static function create(settings:Settings):Sketcher {
		var sketcher = new Sketcher(settings);
		sketcher.baseArray = []; // make sure it's empty
		return sketcher;
	}
}
