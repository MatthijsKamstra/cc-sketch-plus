package examples;

import js.Browser.*;
import sketcher.util.GridUtil;

class ExImage {
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	public function new() {
		// sketcher.util.EmbedUtil.quicksettings();
		// sketcher.util.EmbedUtil.datgui();
		// sketcher.util.EmbedUtil.sanitize();
		// sketcher.util.EmbedUtil.ficons();
		// sketcher.util.EmbedUtil.bootstrap();
		// sketcher.util.EmbedUtil.stats();
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

		var p = grid.array[0];
		var image = sketch.makeImage(p.x, p.y, "https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png", 100, 100);

		var p = grid.array[1];
		var image = sketch.makeImage(p.x, p.y, "https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png", 100, 100);
		image.setRotate(90, p.x, p.y);

		var p = grid.array[3];
		var image = sketch.makeImage(p.x, p.y, "https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png", 50, 50, true);

		var p = grid.array[4];
		var image = sketch.makeImage(p.x, p.y, "https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png", 50, 50, true);
		image.setRotate(90, p.x, p.y);

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
