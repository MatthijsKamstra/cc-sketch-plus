package examples;

import sketcher.util.EmbedUtil;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class ExGui {
	var radiusSmall:Float = 50;
	//
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;

	// dat
	var message = 'dat.gui';
	var speed = 0.8;
	var displayOutline = false;
	var noiseStrength = 0.8;
	var growthSpeed = 0.8;
	var maxSize = 0.8;
	var explode = function() {
		trace('booom');
	};

	var color0 = "#ffae23"; // CSS string
	var color1 = [0, 128, 255]; // RGB array
	var color2 = [0, 128, 255, 0.3]; // RGB with alpha
	var color3 = {h: 350, s: 0.9, v: 0.3}; // Hue, saturation, value

	public function new() {
		init();
	}

	function init() {
		// to connected to sketch
		grid = new GridUtil(sketchWidth, sketchHeight);
		grid.setNumbered(3, 3); // 3 horizontal, 3 vertical
		grid.setIsCenterPoint(true); // default true, but can be set if needed

		initDocument(); // if document doesn't have elements with correct id
		// initDatGui();
		EmbedUtil.datgui(initDatGui2);
		// EmbedUtil.datgui(initDatGui);
		sketchSVG();
		sketchCanvas();
	}

	function initDatGui2() {
		var text = new FizzyText();
		var gui = new js.dat.gui.GUI();
		gui.add(text, 'message');
		gui.add(text, 'speed', -5, 5);
		gui.add(text, 'displayOutline');
		gui.add(text, 'explode');
	}

	function initDatGui() {
		var gui = new js.dat.gui.GUI();
		gui.add(this, 'message');
		gui.add(this, 'speed', -5, 5);
		gui.add(this, 'displayOutline');
		gui.add(this, 'explode');

		var f1 = gui.addFolder('Flow Field');
		f1.add(this, 'speed');
		f1.add(this, 'noiseStrength');

		var f2 = gui.addFolder('Letters');
		f2.add(this, 'growthSpeed');
		f2.add(this, 'maxSize');
		f2.add(this, 'message');

		// Choose from accepted values
		gui.add(this, 'message', ['pizza', 'chrome', 'hooray']);

		// // Choose from named values
		gui.add(this, 'speed', {Stopped: 0, Slow: 0.1, Fast: 5});

		gui.addColor(this, 'color0');
		gui.addColor(this, 'color1');
		gui.addColor(this, 'color2');
		gui.addColor(this, 'color3');

		var controller = gui.add(this, 'maxSize', 0, 10);
		controller.onChange(function(value) {
			// Fires on every change, drag, keypress, etc.
			trace('value: $value');
		});

		controller.onFinishChange(function(value) {
			// Fires when a controller loses focus.
			js.Browser.alert("The new value is " + value);
		});
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
		var circle = sketch.makeCircle(p.x, p.y, radiusSmall);

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}

class FizzyText {
	public var message = 'dat.gui';
	public var speed = 0.8;
	public var displayOutline = false;
	public var explode = function() {
		trace("BOOM");
	};

	public function new() {}
}
