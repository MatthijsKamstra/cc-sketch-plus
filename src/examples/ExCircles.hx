package examples;

import sketcher.draw.AST.LineCap;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExCircles {
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

		var p = grid.array[1];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.fillColor = getColourObj(LIME);

		var p = grid.array[2];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.fillColor = getColourObj(LIME);
		circle.lineWeight = 10;

		var p = grid.array[3];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 10;
		circle.fillColor = getColourObj(PINK);
		circle.fillOpacity = 0.5;

		var p = grid.array[4];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 10;
		circle.fillColor = getColourObj(PINK);
		circle.fillOpacity = 0.5;
		circle.strokeColor = getColourObj(GREEN);

		var p = grid.array[5];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 10;
		circle.fillColor = getColourObj(PINK);
		circle.fillOpacity = 0.5;
		circle.strokeColor = getColourObj(GREEN);
		circle.strokeOpacity = 0.5;

		var p = grid.array[6];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 10;
		circle.fillColor = getColourObj(PINK);
		circle.fillOpacity = 0;
		circle.strokeColor = getColourObj(FUCHSIA);

		var p = grid.array[7];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 20;
		circle.fillOpacity = 0;
		circle.strokeColor = getColourObj(FUCHSIA);
		circle.dash = [omtrek / 8];

		var p = grid.array[8];
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);
		circle.lineWeight = 20;
		circle.fillOpacity = 0;
		circle.strokeColor = getColourObj(FUCHSIA);
		circle.dash = [omtrek / 8];
		circle.lineCap = LineCap.Round;

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
