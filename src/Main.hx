package;

import sketcher.App;
import js.Browser.*;

class Main {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			// DOM ready
			console.log('${App.NAME} :: build: ${App.getBuildDate()}');
			init();
		});
	}

	function init() {
		initDocument(); // if document doesn't have elements with correct id
		sketchSVG();
		sketchCanvas();
	}

	function initDocument() {
		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';
		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';
		document.body.appendChild(div0);
		document.body.appendChild(div1);
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
		circle.lineWeight = 5;

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
		circle.lineWeight = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.opacity = 0.75;
		rect.noStroke();

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	static public function main() {
		var app = new Main();
	}
}
