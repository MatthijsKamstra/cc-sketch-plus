package examples;

import sketcher.draw.AST.LineCap;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExLine {
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
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 10;
		line.strokeColor = getColourObj(RED);

		var p = grid.array[1];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 10;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(GREEN);

		var p = grid.array[2];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 10;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(LIME);
		line.dash = [20, 10];

		var p = grid.array[3];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 10;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(PINK);
		line.setRotate(10, p.x, p.y); // doesn't work for svg or canvas

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
