package;

import Globals.Globals.*;
import Settings.SizeType;
import sketcher.draw.AST.LineCap;
import sketcher.log.Colors.*;
import sketcher.log.Logger.*;
import sketcher.util.ColorUtil.*;
import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class MainInterp {
	public function new() {
		info('MainInterp');
		init();
	}

	function init() {
		sketchSVG();
	}

	function sketchSVG() {
		var size = (Paper.inMM(Paper.PaperSize.A4));

		var sketchWidth = size.width;
		var sketchHeight = size.height;

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

		var designArr:Array<IBase> = [];
		var textArr:Array<IBase> = [];

		var rect = sketch.makeRectangle(0, 0, 50, 50);
		rect.id = 'rect without group';
		rect.setFill(colorArr[0]);

		var rect = sketch.makeRectangle(100, 0, 50, 50);
		rect.id = 'rect in design';
		rect.setFill(colorArr[1]);
		designArr.push(rect);

		var group = sketch.makeGroup(designArr);
		group.id = 'Design Layer';

		// var colorBg = sketch.makeRectangle(w2, h2, w, h);
		// colorBg.setFill(colorArr[0]);

		// for (i in 0...100) {
		// 	var circle = sketch.makeCircle(MathUtil.random(w), MathUtil.random(h), MathUtil.clamp(MathUtil.random(200), 50, 200));
		// 	circle.setFill(colorArr[MathUtil.randomInt(0, colorArr.length - 1)]);
		// }

		// trace(sketch);

		// warn(sketch.update());

		// warn(sketch.update());
		var folder = 'export';
		// ${DateTools.format(Date.now(), '%Y-%m-%d_%H:%M:%S')}
		var filename = 'test_interp.svg';
		writeFile(folder, filename, sketch.update());

		// open file in default program for svg edit (in my case Inkscape)
		Sys.command('open', ['${folder}/${filename}']);
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
		var app = new MainInterp();
	}
}
