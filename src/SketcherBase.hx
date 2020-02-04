package;

import Sketcher.Globals.*;
import js.Browser.*;
import js.html.*;
import js.html.MouseEvent;
import js.html.CanvasElement;

// import cc.tool.ExportFile;

/**
 * Use extends SketchBase to create a quick base to work with
 */
class SketcherBase {
	public var isDrawActive:Bool = true;
	public var isDebug:Bool = false;

	public var sketch:Sketcher;

	/**
	 * constructor
	 * @param ctx
	 */
	public function new(?settings:Settings) {
		if (isDebug)
			trace('START :: ${toString()}');

		// trace('${settings}');

		if (settings != null && settings.element != null)
			trace(settings.element);

		if (settings.elementID != null && document.getElementById(settings.elementID) == null) {
			var div0 = document.createDivElement();
			div0.id = '${settings.elementID}';
			div0.className = 'sketcher-wrapper ${settings.type}-wrapper';
			document.body.appendChild(div0);
			// var elem = document.getElementById('sketcher-svg');
			sketch = Sketcher.create(settings).appendTo(div0);
		} else {
			sketch = Sketcher.create(settings).appendTo(document.getElementById(settings.elementID));
		}

		// sketch = Sketcher.create(settings).appendTo(document.getElementById(settings.elementID));

		window.addEventListener(RESIZE, _reset, false);
		window.addEventListener(KEY_DOWN, _keyDown, false);
		window.addEventListener(KEY_UP, _keyUp, false);
		// window.addEventListener(KEY_DOWN, onKeyDown);

		setup();
		_draw(); // start draw loop

		// haxe.Timer.delay(function() {}, 500);
	}

	// ____________________________________ private ____________________________________
	// track key functions
	function _keyDown(e:js.html.KeyboardEvent) {
		switch (e.key) {
			case ' ':
				draw();
			default:
				// trace("case '" + e.key + "': trace ('" + e.key + "');");
		}
	}

	function _keyUp(e:js.html.KeyboardEvent) {}

	// trigger when window resize, draw function is still running, so clear canvas and restart with init
	function _reset() {
		// trace("wip");
		// ctx.clearRect(0, 0, w, h);
		_draw();
	}

	// wrapper around the real `draw` class
	function _draw(?timestamp:Float) {
		draw();
		__export();
		if (isDrawActive)
			window.requestAnimationFrame(_draw);
	}

	// ____________________________________ public ____________________________________

	/**
	 * setup your art here, is also the best place to reset data
	 * when the browser resizes
	 */
	public function setup() {
		if (isDebug)
			trace('SETUP :: ${toString()} -> override public function draw()');
	}

	/**
	 * the magic happens here, every class should have a `draw` function
	 */
	public function draw() {
		if (isDebug)
			trace('DRAW :: ${toString()} -> override public function draw()');
	}

	/**
	 * might be completely useless, might change in the future,
	 * but this is my library so deal with it
	 * I need this for my export functions
	 */
	public function __export() {
		// if (isDebug)
		// trace('EXPORT :: ${toString()} -> override public function __export()');
	}

	/**
	 * pause the draw function (toggle function)
	 */
	public function pause() {
		isDrawActive = !isDrawActive;
	}

	/**
	 * stop draw function
	 */
	public function stop() {
		isDrawActive = false;
	}

	/**
	 * play draw function
	 */
	public function play() {
		isDrawActive = true;
		_draw();
	}

	public function start() {
		play();
	}

	public function onKeyDown(e:js.html.KeyboardEvent) {
		// switch (e.key) {
		// 	case ' ':
		// 		drawShape();
		// 	default:
		// 		trace("case '" + e.key + "': trace ('" + e.key + "');");
		// }
	}

	/**
	 * shorthand to get half `w` (width of canvas)
	 */
	@:isVar public var w2(get, null):Float;

	function get_w2() {
		return w / 2;
	}

	/**
	 * shorthand to get half `h` (height of canvas)
	 */
	@:isVar public var h2(get, null):Float;

	function get_h2() {
		return h / 2;
	}

	/**
	 * shorthand to get quarter `w` (width of canvas)
	 */
	@:isVar public var w4(get, null):Float;

	function get_w4() {
		return w / 4;
	}

	/**
	 * shorthand to get quarter `h` (height of canvas)
	 */
	@:isVar public var h4(get, null):Float;

	function get_h4() {
		return h / 4;
	}

	/**
	 * shorthand to get third `w` (width of canvas)
	 */
	@:isVar public var w3(get, null):Float;

	function get_w3() {
		return w / 3;
	}

	/**
	 * shorthand to get third `h` (height of canvas)
	 */
	@:isVar public var h3(get, null):Float;

	function get_h3() {
		return h / 3;
	}

	/**
	 * Get className, with package
	 * @example:
	 * 		trace(toString()); // this file would be "art.CCBase"
	 */
	public function toString() {
		var className = Type.getClassName(Type.getClass(this));
		return className;
	}
}
