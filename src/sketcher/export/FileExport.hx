package sketcher.export;

import js.Browser.*;
import js.Browser.window;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

using StringTools;

class FileExport {
	/**
	 * probably only for webgl
	 * @param domElement
	 * @param isJpg
	 * @param fileName
	 */
	public static function downloadWebGLImage(domElement:CanvasElement, ?isJpg:Bool = false, ?fileName:String = "test") {
		var imgData:String;
		var ext = (isJpg) ? 'jpg' : 'png';
		try {
			// imgData = domElement.toDataURL();
			var strDownloadMime = "image/octet-stream";
			var strMime = "image/jpeg";
			imgData = domElement.toDataURL(strMime);
			console.log(imgData);

			FileExport.saveFile(imgData.replace(strMime, strDownloadMime), fileName + '.${ext}');
		} catch (e:Dynamic) {
			console.log("Browser does not support taking screenshot of 3d context");
			return;
		}
	}

	/**
	 * [Description]
	 * @param svg				source
	 * @param isJpg				is this a jpg (or png)
	 * @param filename			file name
	 * @param isTransparant		only usefull when using png
	 */
	public static function svg2Canvas(?svg:js.html.svg.SVGElement, isJpg:Bool = true, filename:String, isTransparant:Bool = false) {
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
			FileExport.downloadImageBg(ctx, isJpg, filename, isTransparant);
		}
		image.onerror = function(e) {
			console.warn(e);
		}
		// make it base64
		image.src = 'data:image/svg+xml;base64,${window.btoa(svg.outerHTML)}';
		// document.body.appendChild(canvas);
	}

	public static function saveFile(strData:String, fileName:String) {
		var link = document.createAnchorElement();
		document.body.appendChild(link); // Firefox requires the link to be in the body
		link.href = strData;
		link.download = fileName;
		link.click();
		document.body.removeChild(link); // remove the link when done
	}

	/**
	 * [Description]
	 * @param ctx
	 * @param isJpg
	 * @param fileName
	 */
	public static function downloadImage(ctx:CanvasRenderingContext2D, ?isJpg:Bool = false, ?fileName:String) {
		if (fileName == null) {
			var hash = js.Browser.location.hash;
			hash = hash.replace('#', '').toLowerCase();
			if (hash == '')
				hash = 'image';
			fileName = '${hash}-${Date.now().getTime()}';
			// fileName = 'cc-art-${Date.now().getTime()}';
		}
		var link = document.createAnchorElement();
		link.href = ctx.canvas.toDataURL((isJpg) ? 'image/jpeg' : '', 1);
		link.download = fileName;
		link.click();
	}

	/**
	 * [Description]
	 * @param ctx
	 * @param isJpg
	 */
	public static function onBase64Handler(ctx:CanvasRenderingContext2D, ?isJpg:Bool = false) {
		var base64 = ctx.canvas.toDataURL((isJpg) ? 'image/jpeg' : '', 1);
		// var base64 = ctx.toDataURL(); // default png
		clipboard(base64);
	}

	/**
	 * Start file download.
	 * cc.tool.FileExport.downloadTextFile("This is the content of my file :)", "hello.txt");
	 *
	 * @param text
	 * @param fileName
	 */
	public static function downloadTextFile(text:String, ?fileName:String) {
		if (fileName == null)
			fileName = 'CC-txt-${Date.now().getTime()}.txt';

		var el = document.createAnchorElement();
		el.href = 'data:text/plain;charset=utf-8,' + untyped encodeURIComponent(text);
		el.download = fileName;

		el.style.display = 'none';
		document.body.appendChild(el);

		el.click();

		document.body.removeChild(el);
	}

	public static function convertStr2Href(str:String):String {
		return 'data:text/plain;charset=utf-8,' + untyped encodeURIComponent(str);
	}

	/**
	 * [Description]
	 * @example
	 * 			utils.Clipboard.copy('hello');
	 * @param text 	value you want to export (probably base64)
	 */
	public static function clipboard(text:String) {
		var win = 'Ctrl+C';
		var mac = 'Cmd+C';
		var copyCombo = win;
		var userAgent = untyped js.Browser.navigator.userAgent;
		var ereg = new EReg("iPhone|iPod|iPad|Android|BlackBerry", "i");
		var ismac = ereg.match(userAgent);
		if (ismac)
			copyCombo = mac;
		window.prompt('Copy to clipboard: $copyCombo, Enter', text);
	}

	/**
	 * Returns contents of a canvas as a png based data url, with the specified background color
	 *
	 * just change the background to white... it really doesn't matter, when exporting a jpg
	 *
	 * @param ctx				canvas
	 * @param isJpg				is this a jpg or png
	 * @param fileName 			name of file without extension (example: `foobar`)
	 * @param isTransparant		only usefull for png
	 */
	public static function downloadImageBg(ctx:CanvasRenderingContext2D, ?isJpg:Bool = false, ?fileName:String, ?isTransparant:Bool = false) {
		trace(ctx, isJpg, fileName, isTransparant);

		var canvas = ctx.canvas;
		var ext = (isJpg) ? 'jpg' : 'png';

		if (fileName == null) {
			var hash = js.Browser.location.hash;
			hash = hash.replace('#', '').toLowerCase();
			if (hash == '')
				hash = 'image';
			fileName = '${hash}-${Date.now().getTime()}';
			// fileName = 'cc-art-${Date.now().getTime()}';
		}

		// cache height and width
		var _w = canvas.width;
		var _h = canvas.height;

		// if (!isTransparant) {
		// 	trace('dddddd');
		// 	// get the current ImageData for the canvas.
		// 	var data = ctx.getImageData(0, 0, _w, _h);

		// 	// store the current globalCompositeOperation
		// 	var compositeOperation = ctx.globalCompositeOperation;

		// 	// set to draw behind current content
		// 	ctx.globalCompositeOperation = "destination-over";

		// 	// set background color
		// 	ctx.fillStyle = '#ff3333';

		// 	// draw background / rect on entire canvas
		// 	ctx.fillRect(0, 0, _w, _h);

		// 	// get the image data from the canvas
		// 	var imageData = canvas.toDataURL("image/png");

		// 	// clear the canvas
		// 	ctx.clearRect(0, 0, _w, _h);

		// 	// restore it with original / cached ImageData
		// 	ctx.putImageData(data, 0, 0);

		// 	// reset the globalCompositeOperation to what it was
		// 	ctx.globalCompositeOperation = compositeOperation;
		// 	// return;
		// }

		if (!isTransparant) {
			// trace('try something else');
			var currentCanvas:CanvasElement = ctx.canvas;
			var newCanvas:CanvasElement = untyped currentCanvas.cloneNode(true);
			var n_ctx = newCanvas.getContext2d();
			n_ctx.fillStyle = "#FFffff";
			n_ctx.fillRect(0, 0, newCanvas.width, newCanvas.height);
			n_ctx.drawImage(canvas, 0, 0);
			ctx.drawImage(newCanvas, 0, 0);
			// return;
		}

		var link = document.createAnchorElement();

		link.style.cssText = "display:none";
		link.download = fileName + '.${ext}';

		// trace(link.download);
		// not sure how to do this in Haxe, so untyped to the resque
		if (!untyped HTMLCanvasElement.prototype.toBlob) {
			trace('There is no blob');
			link.href = ctx.canvas.toDataURL((isJpg) ? 'image/jpeg' : '', 1);
			link.click();
			link.remove();
		} else {
			// https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/toBlob
			trace('Attack of the blob');
			ctx.canvas.toBlob(function(blob) {
				link.href = js.html.URL.createObjectURL(blob);
				link.click();
				link.remove();
			}, (isJpg) ? 'image/jpeg' : '', 1);
		}
		document.body.appendChild(link);
	}

	// ____________________________________ toString() ____________________________________

	function toString():String {
		return '[FileExport]';
	}
}
