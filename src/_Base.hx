package svg;

import cc.model.constants.Paper.*;
import draw.IBase; // sketch-plus
import draw.Text;
import Sketch;
import cc.util.ColorUtil.*;
import js.Browser.*;

using StringTools;

class Base extends SketcherBase {
	public var settings:Settings;

	public var isFondEmbedded:Bool = false;
	public var shapeName:String;

	var dashArray = [5];
	var mm20:Int = Math.ceil(mm2pixel(20));

	var cx:Float;
	var cy:Float;

	var patternName = "";
	var description = "";

	var backgroundColor = getColourObj(WHITE);
	var forgroundColor = getColourObj(BLACK);

	public function new(?set:Settings) {
		// var paperW = 210; // mm
		// var paperH = 297; // mm
		// var paperW = 1080; // 1024; // video?
		// var paperH = 1080; // 1024; // video?
		if (set == null) {
			var paperW = Math.ceil(mm2pixel(210));
			var paperH = Math.ceil(mm2pixel(210));

			this.cx = (paperW / 2);
			this.cy = (paperH / 2);

			this.settings = new Settings(paperW, paperH, 'svg');
			settings.autostart = true;
			settings.padding = 10;
			settings.scale = false;
			settings.elementID = 'sketcher-svg-wrapper';
		} else {
			this.settings = set;

			this.cx = this.settings.width / 2;
			this.cy = this.settings.height / 2;
		}
		// use debug?
		this.isDebug = true;

		// key short cuts
		setupKey();

		// init with correct files
		super(settings);
	}

	function setupKey() {
		console.info('Keyboard Shortcuts are activated:\n\n- [cmd + r] = reload page\n- [cmd + s] = save jpg\n- [cmd + shift + s] = save png\n- [cmd + ctrl + s] = save transparant png\n- [cmd + alt + s] = save svg');
		window.addEventListener(KEY_DOWN, function(e:js.html.KeyboardEvent) {
			// console.log(e);
			// console.log('ctrl: ' + e.ctrlKey);
			// console.log('meta: ' + e.metaKey);
			if (e.metaKey == true && e.key == 'r') {
				trace('cmd + r');
				// reload
				location.reload();
			}
			if (e.metaKey == true && e.key == 's' && e.shiftKey == false && e.ctrlKey == false) {
				e.preventDefault();
				e.stopPropagation();
				trace('cmd + s');
				// jpg
				// ExportFile.downloadImageBg(ctx, true); // jpg
				svg2Canvas(getSvg(), true, getFileName());
			}
			if (e.metaKey == true && e.key == 's' && e.shiftKey == true) {
				e.preventDefault();
				e.stopPropagation();
				trace('cmd + shift + s');
				// png
				svg2Canvas(getSvg(), false, getFileName());
			}
			if (e.metaKey == true && e.key == 's' && e.ctrlKey == true) {
				e.preventDefault();
				e.stopPropagation();
				trace('cmd + ctrl + s');
				// png transparant
				svg2Canvas(getSvg(), false, getFileName(), true);
			}
			if (e.metaKey == true && untyped e.code == 'KeyS' && e.altKey == true) {
				e.preventDefault();
				e.stopPropagation();
				trace('cmd + alt + s');
				// svg
				// ExportFile.onBase64Handler(ctx, true);
				downloadTextFile(getSvg().outerHTML, '${getFileName()}.svg');
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
		}, false);
	}

	function getFileName():String {
		if (patternName == "" && description == "") {
			patternName = 'PatternDesign - MatthijsKamstra';
		} else if (patternName == "" && description != "") {
			patternName = description;
		}
		return '${patternName.replace(' ', '_')}-${Date.now().getTime()}';
	}

	function getSvg():js.html.svg.SVGElement {
		var svg:js.html.svg.SVGElement = cast document.getElementsByTagName('svg')[0];
		return svg;
	}

	function downloadTextFile(text:String, ?fileName:String) {
		if (fileName == null)
			fileName = '${getFileName()}.txt';

		var element = document.createElement('a');
		element.setAttribute('href', 'data:text/plain;charset=utf-8,' + untyped encodeURIComponent(text));
		element.setAttribute('download', fileName);

		element.style.display = 'none';
		document.body.appendChild(element);

		element.click();

		document.body.removeChild(element);
	}

	/**
	 * [Description]
	 * @param svg				source
	 * @param isJpg				is this a jpg (or png)
	 * @param filename			file name
	 * @param isTransparant		only usefull when using png
	 */
	function svg2Canvas(?svg:js.html.svg.SVGElement, isJpg:Bool = true, filename:String, isTransparant:Bool = false) {
		var svgW = Std.parseInt(svg.getAttribute('width'));
		var svgH = Std.parseInt(svg.getAttribute('height'));

		var canvas = document.createCanvasElement();
		var ctx = canvas.getContext2d();
		canvas.width = svgW;
		canvas.height = svgH;

		var image = new js.html.Image();
		image.onload = function() {
			// downloadImageBg doesn't work... so just fix it here
			// jpg image has a white background, png can be transparant
			if (isJpg) {
				ctx.fillStyle = "white";
				ctx.fillRect(0, 0, canvas.width, canvas.height);
			}
			ctx.drawImage(image, 0, 0, svgW, svgH);
			cc.tool.ExportFile.downloadImageBg(ctx, isJpg, filename, isTransparant);
		}
		image.src = 'data:image/svg+xml,${svg.outerHTML}';
		// document.body.appendChild(canvas);
	}

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

	/**
		var attr = cast(e.currentTarget, js.html.AnchorElement).getAttribute('download-id');
		var wrapperDiv = (cast(e.currentTarget, js.html.AnchorElement).parentElement.parentElement);
		var svg:js.html.svg.SVGElement = cast wrapperDiv.getElementsByTagName('svg')[0];
		var filename = '${wrapperDiv.id}_${Date.now().getTime()}';
	 */
	override function draw() {
		console.log('DRAW (PapertoySketcherBase) :: ${toString()}');
		sketch.clear();
	}

	override public function toString() {
		var className = Type.getClassName(Type.getClass(this));
		return className.split('.')[1];
	}
}
