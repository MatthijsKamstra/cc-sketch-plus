package examples;

import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExPath {
	var radiusSmall:Float = 50;
	//
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	public function new() {
		init();
	}

	function init() {
		// to connected to sketch
		grid = new GridUtil(sketchWidth, sketchHeight);
		grid.setNumbered(3, 3); // 3 horizontal, 3 vertical
		grid.setIsCenterPoint(true); // default true, but can be set if needed

		initDocument(); // if document doesn't have elements with correct id
		sketchSVG();
		sketchCanvas();
	}

	function initDocument() {
		var wrapper = document.createDivElement();
		wrapper.id = 'sketcher-wrapper';
		wrapper.className = 'container';

		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';

		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';

		wrapper.appendChild(div0);
		wrapper.appendChild(div1);
		document.body.appendChild(wrapper);
	}

	function sketchSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg');
		var settings:Settings = new Settings(sketchWidth, sketchHeight, 'svg');
		var sketch = Sketcher.create(settings).appendTo(elem);

		generateShapes(sketch);
	}

	function sketchCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas');
		var settings:Settings = new Settings(sketchWidth, sketchHeight, 'canvas');
		var sketch = Sketcher.create(settings).appendTo(elem);

		generateShapes(sketch);
	}

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		var omtrek = MathUtil.circumferenceCircle(radiusSmall);
		var p = grid.array[0];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
