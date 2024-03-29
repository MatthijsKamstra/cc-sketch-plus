package;

import Globals.Globals.*;
import Settings.SizeType;
import js.Browser.*;
import js.Node;
import js.node.Fs;
import sketcher.draw.AST.LineCap;
import sketcher.draw.AST.LineCap;
import sketcher.export.FileExport;
import sketcher.util.ColorUtil;
import sketcher.util.GridUtil;
import sketcher.util.MathUtil;

//
class MainNode {
	public function new() {
		trace('MainNode');
		init();
	}

	function init() {
		sketchSVG();
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

		var sketch = SketcherSVG.create(settings).setup();

		var bg = sketch.makeBackground('white');

		for (i in 0...10) {
			var circle = sketch.makeCircle(MathUtil.random(w), MathUtil.random(h), MathUtil.clamp(MathUtil.random(200), 50, 200));
			var color = ColorUtil.niceColor100[MathUtil.randomInt(ColorUtil.niceColor100.length - 1)];
			circle.setFill(color[0]);
		}

		// trace(sketch);

		trace(sketch.update());

		writeFile('export', 'test_node.svg', sketch.update());
	}

	/**
	 * simply write the files
	 * @param path 		folder to write the files (current assumption is `EXPORT`)
	 * @param filename	(with extension) the file name
	 * @param content	what to write to the file (in our case markdown)
	 */
	function writeFile(path:String, filename:String, content:String) {
		if (!sys.FileSystem.exists(path)) {
			sys.FileSystem.createDirectory(path);
		}
		// write the file
		sys.io.File.saveContent(path + '/${filename}', content);
		trace('written file: ${path}/${filename}');
	}

	static public function main() {
		var app = new MainNode();
	}
}
