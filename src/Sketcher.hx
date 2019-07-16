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

	public function makeLine(x1, y1, x2, y2):Void {
		// your code
	}

	public function makeEllipse(x, y, width, height):Void {
		// your code
	}

	public function makePolygon(ox, oy, r, sides):Void {
		// your code
	}

	// ____________________________________ update ____________________________________

	public function update() {
		trace('WIP update');
		if (settings.type == 'svg') {
			trace('${settings.type}');

			// [mck] TODO change string into XML!!!
			var paper = '<?xml version="1.0" standalone="no"?><svg width="${settings.width}" height="${settings.height}" version="1.1" xmlns="http://www.w3.org/2000/svg">';
			for (i in 0...baseArray.length) {
				var base = baseArray[i];
				var draw = base.svg(settings);
				// trace(base.toString());
				// trace(draw);
				paper += draw;
			}
			paper += '</svg>';

			element.innerHTML = (paper);
		} else {
			trace('${settings.type}');
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
