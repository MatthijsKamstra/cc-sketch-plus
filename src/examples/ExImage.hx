package examples;

import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.load.Loader;

class ExImage {
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;
	var IMAGE_FRAME = new js.html.Image();
	var IMAGE_VIRUS = new js.html.Image();

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

		var load = Loader.create().isDebug(false)
			.add('img/virus.png')
			.add('img/frame.png')
			.onComplete(onCompleteHandler).load();

		initDocument(); // if document doesn't have elements with correct id
		// wait till image is loaded
		// sketchSVG();
		// sketchCanvas();
	}

	function onCompleteHandler(completeArray:Array<LoaderObj>) {
		trace('onCompleteHandler: ' + completeArray.length);
		var l:LoaderObj = completeArray[0];
		console.log(l);
		console.log('loading time: ' + l.time.durationMS + 'ms');
		// console.log(l.filesize);
		console.log(l.image);

		IMAGE_VIRUS = l.image;

		console.log('Image is loaded');

		// now we can use the image
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

		var p = grid.array[2];
		var image = sketch.makeImageFromImage(p.x, p.y, IMAGE_VIRUS, 100, 100, true);

		var p = grid.array[5];
		var image = sketch.makeImageFromImage(p.x, p.y, IMAGE_VIRUS, 100, 100, true);

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}
