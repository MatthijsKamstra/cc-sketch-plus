package examples;

import sketcher.draw.AST.LineJoin;
import sketcher.draw.AST.LineCap;
import sketcher.AST.Point;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExPolyline {
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
		var sides:Array<Float> = [0, 100, 50, 25, 50, 75, 100, 0];

		var p = grid.array[0];
		var shape = sketch.makePolyLine(getSides(p));

		var p = grid.array[1];
		var shape = sketch.makePolyLine(getSides(p));
		shape.strokeColor = getColourObj(GREEN);

		var p = grid.array[2];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillColor = getColourObj(PINK_HOT);
		shape.strokeColor = getColourObj(GREEN);

		var p = grid.array[3];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillColor = getColourObj(PINK_HOT);
		shape.strokeColor = getColourObj(GREEN);
		shape.strokeWeight = 5;

		var p = grid.array[4];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillColor = getColourObj(PINK_HOT);
		shape.strokeColor = getColourObj(GREEN);
		shape.strokeWeight = 15;
		shape.dash = [5, 10];

		var p = grid.array[5];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillColor = getColourObj(PINK_HOT);
		shape.strokeColor = getColourObj(GREEN);
		shape.strokeWeight = 5;
		shape.dash = [5, 10];
		shape.lineCap = LineCap.Round;

		var p = grid.array[6];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(MAROON);
		shape.strokeWeight = 10;
		shape.lineCap = LineCap.Round;

		var p = grid.array[7];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(LIME);
		shape.strokeWeight = 10;
		shape.lineCap = LineCap.Round;
		shape.lineJoin = LineJoin.Round;

		var p = grid.array[8];
		var shape = sketch.makePolyLine(getSides(p));
		shape.fillOpacity = 0;
		shape.strokeColor = getColourObj(LIME);
		shape.strokeWeight = 10;
		shape.lineCap = LineCap.Round;
		shape.lineJoin = LineJoin.Round;
		shape.setRotate(45, p.x, p.y);

		// Don't forget to tell two to render everything to the screen

		sketch.update();
	}

	function getSides(p:Point):Array<Float> {
		var sides:Array<Float> = [
			p.x + (-50), p.y + (100 - 50),
			  p.x + (0),  p.y + (25 - 50),
			  p.x + (0),  p.y + (75 - 50),
			 p.x + (50),   p.y + (0 - 50)
		];

		return sides;
	}
}
