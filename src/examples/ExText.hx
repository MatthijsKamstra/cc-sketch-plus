package examples;

import sketcher.draw.Text.TextBaselineType;
import sketcher.draw.Text.TextAlignType;
import sketcher.util.EmbedUtil;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

using StringTools;

class ExText {
	var radiusSmall:Float = 50;
	//
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	var fontFamly = 'Lobster';

	public function new() {
		EmbedUtil.embedGoogleFont(fontFamly, init);
		// init();
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
		// var circle = sketch.makeCircle(p.x, p.y, radiusSmall);

		var p = grid.array[2];
		var shape = sketch.makeText("Test (default)", p.x, p.y);

		var p = grid.array[1];
		var shape = sketch.makeText("Test (pink)", p.x, p.y);
		shape.fillColor = getColourObj(PINK_DEEP);

		var p = grid.array[0];
		var shape = sketch.makeText("Test (24px)", p.x, p.y);
		shape.fillColor = getColourObj(GREEN);
		shape.fontSize = '24px';

		var p = grid.array[3];
		var shape = sketch.makeText("left", p.x, p.y);
		shape.fillColor = getColourObj(MAROON);
		shape.fontSize = '50px';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Left;

		var p = grid.array[4];
		var shape = sketch.makeText("center", p.x, p.y);
		shape.fillColor = getColourObj(MAROON);
		shape.fontSize = '50';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Center;

		var p = grid.array[5];
		var shape = sketch.makeText("right", p.x, p.y);
		shape.fillColor = getColourObj(MAROON);
		shape.fontSize = '50';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Right;

		var p = grid.array[6];
		var shape = sketch.makeText("Right T", p.x, p.y);
		shape.fillColor = getColourObj(OLIVE);
		shape.fontSize = '30';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Right;
		shape.textBaseline = TextBaselineType.Top;

		var p = grid.array[7];
		var shape = sketch.makeText("Right M", p.x, p.y);
		shape.fillColor = getColourObj(OLIVE);
		shape.fontSize = '30';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Right;
		shape.textBaseline = TextBaselineType.Middle;

		var p = grid.array[8];
		var shape = sketch.makeText("Right B", p.x, p.y);
		shape.fillColor = getColourObj(OLIVE);
		shape.fontSize = '30';
		shape.fontFamily = fontFamly.replace("+", " ");
		shape.textAlign = TextAlignType.Right;
		shape.textBaseline = TextBaselineType.Bottom;

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
