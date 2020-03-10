package examples;

import js.Browser.*;
import sketcher.draw.AST.LineCap;
import sketcher.util.ColorUtil.*;
import sketcher.util.GridUtil;

class ExRectangle {
	var rectW:Float = 100;
	var rectH:Float = 50;
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
		// sketchWebgl();
	}

	function initDocument() {
		var wrapper = document.createDivElement();
		wrapper.id = 'sketcher-wrapper';
		wrapper.className = 'container';

		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';

		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';

		var div2 = document.createDivElement();
		div2.id = 'sketcher-canvas-webgl';

		wrapper.appendChild(div0);
		wrapper.appendChild(div1);
		// wrapper.appendChild(div2);

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

	function sketchWebgl() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas-webgl');
		var settings:Settings = new Settings(sketchWidth, sketchHeight, 'webgl');
		var sketch = Sketcher.create(settings).appendTo(elem);

		generateShapes(sketch);
	}

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		var omtrek = (rectW * 2) + (rectH * 2);

		var p = grid.array[0];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.setRotate(10, p.x, p.y);
		shape.fillOpacity = 0.8;
		var poly = sketch.makeX(p.x, p.y, 'black');

		var p = grid.array[1];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH, true);
		shape.fillColor = getColourObj(LIME);
		shape.setRotate(-100, p.x, p.y);
		shape.fillOpacity = 0.8;
		// shape.setScale(1.5, 1.5);
		var poly = sketch.makeX(p.x, p.y, 'black');

		var p = grid.array[2];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.fillColor = getColourObj(LIME);
		shape.lineWeight = 10;

		var p = grid.array[3];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.lineWeight = 10;
		shape.fillColor = getColourObj(PINK);
		shape.fillOpacity = 0.5;
		shape.setMove(10, 10);

		var p = grid.array[4];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH, false);
		shape.lineWeight = 10;
		shape.fillColor = getColourObj(PINK);
		shape.fillOpacity = 0.5;
		shape.strokeColor = getColourObj(GREEN);

		var p = grid.array[5];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.lineWeight = 10;
		shape.fillColor = getColourObj(PINK);
		shape.fillOpacity = 0.5;
		shape.strokeColor = getColourObj(GREEN);
		shape.strokeOpacity = 0.5;

		var p = grid.array[6];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.lineWeight = 10;
		shape.fillColor = getColourObj(PINK);
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(FUCHSIA);

		var p = grid.array[7];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.lineWeight = 10;
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(FUCHSIA);
		shape.dash = [40, 20];

		var p = grid.array[8];
		var shape = sketch.makeRectangle(p.x, p.y, rectW, rectH);
		shape.lineWeight = 10;
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(FUCHSIA);
		shape.dash = [40, 20];
		shape.lineCap = LineCap.Round;

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
