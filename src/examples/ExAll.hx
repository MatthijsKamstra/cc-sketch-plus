package examples;

import sketcher.draw.Text.TextBaselineType;
import sketcher.draw.Text.TextAlignType;
import sketcher.util.EmbedUtil;
import sketcher.draw.AST.LineCap;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExAll {
	var radiusSmall:Float = 50;
	//
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	// font
	var fontFamly = 'Pacifico';

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

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}

	function sketchCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas');
		var settings:Settings = new Settings(sketchWidth, sketchHeight, 'canvas');
		var sketch = Sketcher.create(settings).appendTo(elem);

		generateShapes(sketch);

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		var p = grid.array[0];
		var circle = sketch.makeCircle(p.x, p.y, 50);

		var p = grid.array[1];
		var rect = sketch.makeRectangle(p.x, p.y, 100, 100);

		// The object returned has many stylable properties:
		circle.fill = '#FF8000';
		circle.stroke = '#ff4500'; // Accepts all valid css color
		circle.lineWeight = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.fillOpacity = 0.75;
		rect.noStroke();

		var p = grid.array[2];
		var pct = .77;
		var _stroke = 15;
		var _r = radiusSmall - (_stroke * 0.5);
		var omtrek = MathUtil.circumferenceCircle(_r);
		var dashLine = omtrek * pct;
		var dashNoLine = omtrek - dashLine;

		var circle = sketch.makeCircle(p.x, p.y, _r);
		circle.lineCap = LineCap.Round;
		circle.fillOpacity = 0;
		circle.strokeColor = getColourObj(LIME);
		circle.strokeWeight = _stroke;
		circle.dash = [dashLine, dashNoLine];
		circle.setRotate(-90, p.x, p.y); // rotate it 90 degree to start on top

		var circle2 = sketch.makeCircle(p.x, p.y, _r);
		circle2.fillOpacity = 0;
		circle2.strokeColor = getColourObj(FUCHSIA);
		circle2.strokeWeight = _stroke;
		circle2.strokeOpacity = 0.2;

		var p = grid.array[3];
		var shape = sketch.makeText("center", p.x, p.y);
		shape.fillColor = getColourObj(MAROON);
		shape.fontSize = '50px';
		shape.fontFamily = fontFamly;
		shape.textAlign = TextAlignType.Center;
		shape.textBaseline = TextBaselineType.Middle;

		var p = grid.array[4];
		var image = sketch.makeImage(p.x, p.y, "https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png", 100, 100, true);

		var p = grid.array[5];
		var line = sketch.makeLine(p.x, p.y, p.x + radiusSmall, p.y + radiusSmall);
		line.strokeWeight = 10;
		line.lineCap = LineCap.Round;
		line.strokeColor = getColourObj(LIME);
		line.dash = [10, 20];
	}
}
