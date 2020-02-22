package;

import Sketcher.Globals.*;
import js.Browser.*;
import js.html.*;
import js.html.CanvasElement;
import js.html.MouseEvent;
import sketcher.export.FileExport;

using StringTools;

/**
 * Use extends SketchBase to create a quick base to work with
 */
class SketcherBase {
	public var isDrawActive:Bool = true;
	public var isDebug:Bool = false;

	// only usefull for filename
	public var patternName = "";
	public var description = "";

	// public
	public var sketch:Sketcher;

	/**
	 * constructor
	 * @param ctx
	 */
	public function new(?settings:Settings) {
		if (isDebug)
			trace('START :: ${toString()}');

		// trace('${settings}');

		if (settings == null) {
			// use default settings
			var stageW = 1080; // 1024; // video?
			var stageH = 1080; // 1024; // video?
			settings = new Settings(stageW, stageH, 'canvas');
			settings.autostart = true;
			settings.padding = 10;
			settings.scale = false;
			settings.elementID = 'sketcher-canvas-wrapper';
		}

		if (settings != null && settings.element != null)
			trace(settings.element);

		if (settings.elementID != null && document.getElementById(settings.elementID) == null) {
			// check if html document has this settings.elementID, if not create one
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
		console.groupCollapsed("Default cc-sketcher keyboard shortcuts are activated");
		console.info('• [cmd + r] = reload page\n• [cmd + s] = save jpg\n• [cmd + shift + s] = save png\n• [cmd + ctrl + s] = save transparant png\n• [cmd + alt + s] = save svg');
		console.groupEnd();
	}

	// ____________________________________ private ____________________________________
	// track key functions
	function _keyDown(e:js.html.KeyboardEvent) {
		// console.log(e);
		// console.log('ctrl: ' + e.ctrlKey);
		// console.log('meta: ' + e.metaKey);
		if (e.metaKey == true && e.key == 'r') {
			console.log('[cmd + r] = reload page');
			// reload
			location.reload();
		}
		if (e.metaKey == true && e.key == 's' && e.shiftKey == false && e.ctrlKey == false) {
			e.preventDefault();
			e.stopPropagation();
			console.log('[cmd + s] = save jpg');
			// jpg
			if (sketch.settings.type == 'svg') {
				trace('svg-jpg');
				FileExport.svg2Canvas(sketch.getSVGElement(), true, getFileName());
				// FileExport.svg2Canvas(getSvg(), true, getFileName());
			} else {
				trace('canvas-jpg');
				FileExport.downloadImageBg(sketch.canvas.getContext2d(), true, getFileName());
			}
			// ExportFile.downloadImageBg(ctx, true); // jpg
		}
		if (e.metaKey == true && e.key == 's' && e.shiftKey == true) {
			e.preventDefault();
			e.stopPropagation();
			console.log('[cmd + shift + s] = save png');
			// png
			// svg2Canvas(getSvg(), false, getFileName());

			if (sketch.settings.type == 'svg') {
				trace('svg-png');
				FileExport.svg2Canvas(sketch.getSVGElement(), false, getFileName());
				// FileExport.svg2Canvas(getSvg(), true, getFileName());
			} else {
				trace('canvas-png');
				FileExport.downloadImageBg(sketch.canvas.getContext2d(), false, getFileName());
			}
		}
		if (e.metaKey == true && e.key == 's' && e.ctrlKey == true) {
			e.preventDefault();
			e.stopPropagation();
			console.log('[cmd + ctrl + s] = save transparant png');
			// png transparant
			// svg2Canvas(getSvg(), false, getFileName(), true);
			if (sketch.settings.type == 'svg') {
				trace('svg-png-transparant');
				FileExport.svg2Canvas(sketch.getSVGElement(), false, getFileName(), true);
				// FileExport.svg2Canvas(getSvg(), true, getFileName());
			} else {
				trace('canvas-png-transparant');
				FileExport.downloadImageBg(sketch.canvas.getContext2d(), false, getFileName(), true);
			}
		}
		if (e.metaKey == true && untyped e.code == 'KeyS' && e.altKey == true) {
			e.preventDefault();
			e.stopPropagation();
			console.log('[cmd + alt + s] = save svg');
			// svg
			// ExportFile.onBase64Handler(ctx, true);
			// downloadTextFile(getSvg().outerHTML, '${getFileName()}.svg');
			// sketch.getSVG()
			if (sketch.settings.type == 'svg') {
				trace('svg-text');
				FileExport.downloadTextFile(sketch.svg, '${getFileName()}.svg');
				// FileExport.svg2Canvas(sketch.getSVGElement(), false, getFileName(), true);
				// FileExport.svg2Canvas(getSvg(), true, getFileName());
			} else {
				console.warn('no canvas-2-svg');
			}
		}
		if (e.metaKey == true && e.key == 'f') {
			if (!isFullscreen) {
				openFullscreen();
				isFullscreen = true;
			} else {
				closeFullscreen();
				isFullscreen = false;
			}
		}
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

	// ____________________________________ handlers ____________________________________

	/* View in fullscreen */
	function openFullscreen() {
		var elem = document.documentElement;
		if (elem.requestFullscreen != null) {
			elem.requestFullscreen();
		} else if (untyped elem.mozRequestFullScreen) { /* Firefox */
			untyped elem.mozRequestFullScreen();
		} else if (untyped elem.webkitRequestFullscreen) { /* Chrome, Safari and Opera */
			untyped elem.webkitRequestFullscreen();
		} else if (untyped elem.msRequestFullscreen) { /* IE/Edge */
			untyped elem.msRequestFullscreen();
		}
	}

	/* Close fullscreen */
	function closeFullscreen() {
		if (document.exitFullscreen != null) {
			document.exitFullscreen();
		} else if (untyped document.mozCancelFullScreen) { /* Firefox */
			untyped document.mozCancelFullScreen();
		} else if (untyped document.webkitExitFullscreen) { /* Chrome, Safari and Opera */
			untyped document.webkitExitFullscreen();
		} else if (untyped document.msExitFullscreen) { /* IE/Edge */
			untyped document.msExitFullscreen();
		}
	}

	// ____________________________________ getter/setter ____________________________________

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

	// ____________________________________ misc ____________________________________

	function getFileName():String {
		if (patternName == "" && description == "") {
			patternName = 'CC-Sketcher-MatthijsKamstra';
		} else if (patternName == "" && description != "") {
			patternName = description;
		}
		return '${patternName.replace(' ', '_')}-${Date.now().getTime()}';
	}

	/**
	 * Get className, with package
	 * @example:
	 * 		trace(toString()); // this file would be "SketcherBase"
	 */
	public function toString() {
		var className = Type.getClassName(Type.getClass(this));
		return className;
	}
}
