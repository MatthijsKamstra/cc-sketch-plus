package;

import js.Node;
import js.node.Fs;
//
import Settings.SizeType;
import sketcher.export.FileExport;
import sketcher.draw.AST.LineCap;
import js.Browser.*;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil.*;

class MainNode {
	public function new() {
		trace('MainNode');

		init();
	}

	function init() {
		sketchSVG();

		writeFile();
	}

	function sketchSVG() {
		var sketchWidth = 793.70079;
		var sketchHeight = 1122.5197;

		// Make an instance of two and place it on the page.
		var settings:Settings = new Settings(Math.round(sketchWidth), Math.round(sketchHeight), 'svg');
		settings.isAnimation = false; // default is true (based upon canvas)
		settings.padding = 0;
		settings.isScaled = true; // (default is false)
		settings.sizeType = SizeType.MM;
		settings.viewBox = [0, 0, sketchWidth, sketchHeight];

		var sketch = Sketcher.create(settings); // .appendTo(elem);

		// sketch.svgEl.onclick = function() {
		// 	var filename = 'a4_${Date.now().getTime()}';
		// 	FileExport.downloadTextFile(sketch.svg, filename + '.svg');
		// 	FileExport.svg2Canvas(sketch.getSVGElement(), false, filename);
		// }

		// generateShapes(sketch);
	}

	function writeFile() {
		var str:String = 'Hello World!\nWritten on: ' + Date.now().toString();
		// this code example is closest to the pure node.js example
		Fs.writeFile('hello.txt', str, {}, function(err) {
			if (err != null)
				trace("err: " + err);
			else
				trace('Hello > hello.txt');
		});
	}

	static public function main() {
		var app = new MainNode();
	}
}
