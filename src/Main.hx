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
		sketchRoundedRectSVG();
		sketchRoundedRectCanvas();
		//
		sketchShapes();
		//
		sketchDefaultShapes();
		sketchDefaultShapesC();
	}

	function initDocument() {
		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';
		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';
		document.body.appendChild(div0);
		document.body.appendChild(div1);
	}

	function sketchDefaultShapes() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-defaultshapes');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		var arr = ['square', 'circle', 'line', 'rectangle', 'oval', 'poly', 'group', 'text'];
		var xoffset = 80;
		for (i in 0...arr.length) {
			var xpos = 50 + (i * xoffset);
			var ypos = 180;
			var txt = two.makeText(arr[i], xpos, ypos);
			// txt.style = '';
			var x = two.makeX(xpos, ypos);
		}
		// square

		var _x = 50 + (0 * xoffset);
		var _y = 100;
		var rect = two.makeRectangle(_x, _y, 50, 50);
		// rect.fill = '#fab1a0';
		// rect.stroke = '#ff7675'; // Accepts all valid css color
		var x = two.makeX(_x, _y);

		// circle
		var _x = 50 + (1 * xoffset);
		var circle = two.makeCircle(_x, _y, 25);
		// circle.fill = '#fab1a0';
		// circle.stroke = '#ff7675'; // Accepts all valid css color
		var x = two.makeX(_x, _y);

		// line
		var _x1 = 50 + (2 * xoffset);
		var _x2 = 50 + (3 * xoffset);
		var _y1 = 100;
		var _y2 = 50;
		var line = two.makeLine(_x1, _y1, _x2, _y2);
		var x = two.makeX(_x1, _y1);
		var x = two.makeX(_x2, _y2);

		// rectangle
		var _x = 50 + (3 * xoffset);
		var rect = two.makeRectangle(_x, _y, 100, 50);
		rect.fill = '#fab1a0';
		rect.stroke = '#ff7675'; // Accepts all valid css color
		var x = two.makeX(_x, _y);

		// poly
		var _x = 50 + (5 * xoffset);
		var poly = two.makePolygon([0, 100, 50, 25, 50, 75, 100, 0]);
		poly.id = 'bliksum';
		poly.setTranslate(_x, _y);
		// poly.fill = '#fab1a0';
		// poly.stroke = '#ff7675'; // Accepts all valid css color
		var x = two.makeX(_x, _y);

		// group
		var _x = 50 + (6 * xoffset);
		var circle1 = two.makeCircle(_x, _y + 10, 25);
		circle1.opacity = 0.5;
		var circle2 = two.makeCircle(_x, _y - 10, 25);
		circle2.opacity = 0.5;
		var x = two.makeX(_x, _y);

		// Groups can take an array of shapes and/or groups.
		var group = two.makeGroup(circle1, circle2);
		group.rotation = Math.PI;
		group.scale = 0.75;
		// text example

		var txt = two.makeText("Saira\nStencil\nOne", 50 + ((arr.length - 1) * xoffset), 100);
		txt.style = 'font-family: \'Saira Stencil One\', Arial, cursive; font-size: 50px; fill:red;';

		// var line = two.makeLine(0, 0, 100, 100);

		// Don't forget to tell two to render everything to the screen
		two.update();

		elem.onclick = function(e) {
			// trace(elem.innerHTML);
			downloadTextFile(elem.innerHTML, '${elem.id}_${Date.now().getTime()}.svg');
		};
	}

	function sketchDefaultShapesC() {}

	function sketchShapes() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-shapes');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		var rect = two.makeRoundedRectangle(60, 100, 100, 100, 20);
		rect.fill = '#fab1a0';
		rect.stroke = '#ff7675'; // Accepts all valid css color
		rect.linewidth = 3;

		// var line = two.makeLine(0, 0, 100, 100);

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchRoundedRectSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-roundedrect');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#74b9ff';
			rect.stroke = '#6c5ce7'; // Accepts all valid css color
			rect.linewidth = i;
		}

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchRoundedRectCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas-roundedrect');
		var params:Settings = new Settings(680, 200, 'canvas');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#74b9ff';
			rect.stroke = '#6c5ce7'; // Accepts all valid css color
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

	// ____________________________________ misc ____________________________________

	public static function downloadTextFile(text:String, ?fileName:String) {
		if (fileName == null)
			fileName = 'CC-txt-${Date.now().getTime()}.txt';

		var element = document.createElement('a');
		element.setAttribute('href', 'data:text/plain;charset=utf-8,' + untyped encodeURIComponent(text));
		element.setAttribute('download', fileName);

		element.style.display = 'none';
		document.body.appendChild(element);

		element.click();

		document.body.removeChild(element);
	}

	static function main() {
		var app = new Main();
	}
}
