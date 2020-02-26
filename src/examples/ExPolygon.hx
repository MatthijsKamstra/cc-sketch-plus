package examples;

import sketcher.draw.AST.LineJoin;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExPolygon {
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
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 3, radiusSmall);
		// _polygon.rotate = p.degree;
		_polygon.strokeColor = getColourObj(BLACK);
		_polygon.strokeWeight = 1;
		_polygon.fillOpacity = 0;

		var p = grid.array[1];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 4, radiusSmall);
		_polygon.setRotate(45, p.x, p.y);
		_polygon.setStroke(getColourObj(PINK), 10);
		_polygon.setFill(getColourObj(LIME));

		var p = grid.array[2];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 5, radiusSmall, ((360 / 5) / 4) + (360 / 10) * 1);
		// _polygon.rotate = p.degree;
		_polygon.strokeColor = getColourObj(BLACK);
		_polygon.strokeWeight = 1;
		_polygon.fillOpacity = 0;

		var p = grid.array[3];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 6, radiusSmall);
		// _polygon.rotate = p.degree;
		_polygon.strokeColor = getColourObj(BLACK);
		_polygon.strokeWeight = 1;
		_polygon.fillOpacity = 0;

		var p = grid.array[4];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 7, radiusSmall);
		// _polygon.rotate = p.degree;
		_polygon.strokeColor = getColourObj(BLACK);
		_polygon.strokeWeight = 1;
		_polygon.fillOpacity = 0;

		var p = grid.array[5];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 8, radiusSmall);
		// _polygon.rotate = p.degree;
		_polygon.noStroke();
		_polygon.setFill("#33C4B8");

		var p = grid.array[6];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 4, radiusSmall, 45);
		_polygon.setStroke(getColourObj(PURPLE), 25);
		_polygon.noFill();
		_polygon.lineJoin = LineJoin.Round;

		var p = grid.array[7];
		var _polygon = sketch.makePolygon([]);
		_polygon.sides(p.x, p.y, 5, radiusSmall);
		_polygon.setStroke(getColourObj(RED), 20);
		_polygon.noFill();
		_polygon.setLineEnds();

		// Don't forget to tell two to render everything to the screen

		sketch.update();
	}
}
