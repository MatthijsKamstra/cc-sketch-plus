package examples;

import sketcher.draw.IBase;
import js.Browser.*;
import sketcher.util.ColorUtil;
import sketcher.util.GridUtil;

class GenColors {
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
		// grid.setNumbered(10, 11); // x horizontal, y vertical
		grid.setTotal(ColorUtil.niceColor100SortedString.length);
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

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		// var colorArray = ColorUtil.niceColor100SortedInt[randomInt(ColorUtil.niceColor100SortedInt.length - 1)];

		var arr:Array<Array<String>> = ColorUtil.niceColor100SortedString;
		for (i in 0...arr.length) {
			var sortedColorArr:Array<String> = arr[i];
			var p = grid.array[i];
			var w = 5;
			var h = 20;

			// trace(sortedColorArr);
			var grArr:Array<IBase> = [];
			for (j in 0...sortedColorArr.length) {
				var color = sortedColorArr[j];
				var shape = sketch.makeRectangle(p.x + (j * w), p.y, w, h);
				shape.id = color;
				shape.setFill(color);
				grArr.push(shape);
			}
			var g = sketch.makeGroup(grArr);
		}

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
