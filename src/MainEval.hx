package;

import Globals.Globals.*;
import Settings.SizeType;
import sketcher.draw.AST.LineCap;
import sketcher.log.Colors.*;
import sketcher.log.Logger.*;
import sketcher.util.ColorUtil.*;
import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class MainEval {
	public function new() {
		info('MainEval');
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
		// settings.sizeType = SizeType.MM;
		settings.viewBox = [0, 0, sketchWidth, sketchHeight];

		var sketch = SketcherSVG.create(settings).setup();

		var bg = sketch.makeBackground('white');

		// colors
		var colorArr = ColorUtil.niceColor100SortedString[MathUtil.randomInt(ColorUtil.niceColor100SortedString.length - 1)];

		var colorBg = sketch.makeRectangle(w2, h2, w, h);
		colorBg.setFill(colorArr[0]);

		for (i in 0...100) {
			var circle = sketch.makeCircle(MathUtil.random(w), MathUtil.random(h), MathUtil.clamp(MathUtil.random(200), 50, 200));
			circle.setFill(colorArr[MathUtil.randomInt(0, colorArr.length - 1)]);
		}

		// trace(sketch);

		warn(sketch.update());

		writeFile('bin', 'test_eval.svg', sketch.update());
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
		mute('written file: ${path}/${filename}');
	}

	static public function main() {
		var app = new MainEval();
	}
}
