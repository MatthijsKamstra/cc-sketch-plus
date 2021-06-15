package examples;

import sketcher.export.FileExport;
import sketcher.draw.AST.LineCap;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExSvgA4 {
	var radiusSmall:Float = 50;
	//
	var sketchWidth = 793.70079;
	var sketchHeight = 1122.5197;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	/**
		<svg
		  width="210mm"
		  height="297mm"
		  viewBox="0 0 793.70079 1122.5197"
		  version="1.1"
	 */
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
		// sketchCanvas();
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
		var settings:Settings = new Settings(Math.round(MathUtil.px2mm(sketchWidth)), Math.round(MathUtil.px2mm(sketchHeight)), 'svg');
		settings.isAnimation = false; // default is true (based upon canvas)
		settings.padding = 0;
		settings.isScaled = true; // (default is false)
		settings.sizeType = 'mm';
		settings.viewBox = [0, 0, sketchWidth, sketchHeight];

		var sketch = Sketcher.create(settings).appendTo(elem);

		sketch.svgEl.onclick = function() {
			FileExport.downloadTextFile(sketch.svg, 'a4_${Date.now().getTime()}.svg');
		}

		generateShapes(sketch);
	}

	// function sketchCanvas() {
	// 	// Make an instance of two and place it on the page.
	// 	var elem = document.getElementById('sketcher-canvas');
	// 	var settings:Settings = new Settings(sketchWidth, sketchHeight, 'canvas');
	// 	var sketch = Sketcher.create(settings).appendTo(elem);
	// 	generateShapes(sketch);
	// }

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		var omtrek = MathUtil.circumferenceCircle(radiusSmall);

		// test arrow
		var arrowShape = sketch.makePolygon([0, 0, 10, 3.5, 0, 7]);
		arrowShape.setFill('green');
		arrowShape.setStroke(getColourObj(BLACK));
		arrowShape.setPlusPosition(100, 100);

		var arrowShape = sketch.makePolygon([0, 0, 10, 3.5, 0, 7]);
		// arrowShape.setFill('yellow');
		// arrowShape.setStroke(getColourObj(BLACK));
		var markerArrow = sketch.makeMarker([arrowShape]);
		markerArrow.id = "arrowhead";
		markerArrow.width = 10;
		markerArrow.height = 7;
		markerArrow.refX = 0;
		markerArrow.refY = 3.5;

		var bg = sketch.makeRectangle(0, 0, sketchWidth, sketchHeight, false);
		bg.id = 'background-color';
		bg.setFill(getColourObj(SILVER));

		// test polyline
		var pointerShape = sketch.makePolyLine([1, 1, 9, 5, 1, 9]);
		pointerShape.noFill();
		pointerShape.setStroke(getColourObj(BLACK));
		pointerShape.setPlusPosition(100, 150);

		var pointerShape = sketch.makePolyLine([1, 1, 9, 5, 1, 9]);
		pointerShape.noFill();
		pointerShape.setStroke(getColourObj(BLACK));
		var marker = sketch.makeMarker([pointerShape]);
		marker.id = "pointer";
		marker.width = 9;
		marker.height = 9;
		marker.refX = 9;
		marker.refY = 5;

		var p = grid.array[0];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y);
		line.strokeWeight = 1;
		line.strokeColor = getColourObj(BLACK);
		line.setMarkerEnd(markerArrow.id);

		var p = grid.array[1];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y);
		line.strokeWeight = 1;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(GREEN);
		line.setMarkerEnd(marker.id);

		var p = grid.array[2];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 1;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(LIME);
		line.dash = [5];
		line.setMarkerEnd('arrowhead');

		var p = grid.array[3];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 1;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(PINK);
		line.setMarkerEnd('pointer');

		var p = grid.array[4];
		var line = sketch.makeLine(p.x, p.y, p.x - radiusSmall, p.y + radiusSmall);
		line.strokeColor = getColourObj(BLUE);

		var p = grid.array[5];
		var rect = sketch.makeRectangle(p.x, p.y, MathUtil.mm2pixel(50), MathUtil.mm2pixel(100));
		rect.setStroke(getColourObj(BLUE));
		rect.setFill(getColourObj(MAROON));

		// Don't forget to tell two to render everything to the screen
		sketch.update();
		// sketch.update();
	}
}
