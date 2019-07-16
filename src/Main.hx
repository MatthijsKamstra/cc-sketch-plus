package;

import js.Browser.*;

class Main {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			trace("Start Sketcher");
			init();
		});
	}

	function init() {
		// initDocument(); // if document doesn't have elements with correct id
		sketchSVG();
		sketchCanvas();
		//
		sketchShapesSVG();
		sketchShapesCanvas();
	}

	function initDocument() {
		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';
		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';
		document.body.appendChild(div0);
		document.body.appendChild(div1);
	}

	function sketchShapesSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-shapes');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#FF8000';
			rect.stroke = 'orangered'; // Accepts all valid css color
			rect.linewidth = i;
		}

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchShapesCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas-shapes');
		var params:Settings = new Settings(680, 200, 'canvas');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#FF8000';
			rect.stroke = 'orangered'; // Accepts all valid css color
			rect.linewidth = i;
		}

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg');
		var params:Settings = new Settings(285, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		// two has convenience methods to create shapes.
		var circle = two.makeCircle(72, 100, 50);
		var rect = two.makeRectangle(213, 100, 100, 100);

		// The object returned has many stylable properties:
		circle.fill = '#FF8000';
		circle.stroke = 'orangered'; // Accepts all valid css color
		circle.linewidth = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.opacity = 0.75;
		rect.noStroke();

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas');
		var params:Settings = new Settings(285, 200, 'canvas');
		var two = Sketcher.create(params).appendTo(elem);

		// two has convenience methods to create shapes.
		var circle = two.makeCircle(72, 100, 50);
		var rect = two.makeRectangle(213, 100, 100, 100);

		// The object returned has many stylable properties:
		circle.fill = '#FF8000';
		circle.stroke = 'orangered'; // Accepts all valid css color
		circle.linewidth = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.opacity = 0.75;
		rect.noStroke();

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	static function main() {
		var app = new Main();
	}
}
