package examples;

import sketcher.util.EmbedUtil;
import sketcher.draw.Text.TextAlignType;
import sketcher.util.MathUtil;
import sketcher.util.ColorUtil;
import sketcher.AST.Point;
import js.Browser.*;
import sketcher.draw.AST.LineCap;
import sketcher.util.ColorUtil.*;
import sketcher.util.GridUtil;

class ExMirror {
	var rectW:Float = 100;
	var rectH:Float = 50;
	//
	var sketchWidth = 600;
	var sketchHeight = 400;
	//
	var grid:GridUtil;
	//
	var isDebug:Bool = true;
	var total = 10; // 20;
	var randomArray:Array<RandomRect> = [];

	var fontFamily:String;

	public function new() {
		init();
	}

	function init() {
		// to connected to sketch
		grid = new GridUtil(sketchWidth, sketchHeight);
		grid.setNumbered(3, 3); // 3 horizontal, 3 vertical
		grid.setIsCenterPoint(true); // default true, but can be set if needed

		setupRandom();

		initDocument(); // if document doesn't have elements with correct id
		sketchSVG();
		sketchCanvas();
		// sketchWebgl();
	}

	function setupRandom() {
		randomArray = [];
		for (i in 0...total) {
			var randomRect:RandomRect = {
				point: {
					x: MathUtil.random(sketchWidth),
					y: MathUtil.random(sketchHeight)
				},
				color: ColorUtil.randomColour(),
				rotation: MathUtil.random(360),
				width: MathUtil.random(20, sketchWidth * 0.5),
				height: MathUtil.random(20, sketchHeight * 0.5)
			};
			randomArray.push(randomRect);
		}
	}

	function initDocument() {
		var wrapper = document.createDivElement();
		wrapper.id = 'sketcher-wrapper';
		wrapper.className = 'container';

		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';

		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';

		var div2 = document.createDivElement();
		div2.id = 'sketcher-canvas-webgl';

		wrapper.appendChild(div0);
		wrapper.appendChild(div1);
		// wrapper.appendChild(div2);

		document.body.appendChild(wrapper);

		fontFamily = EmbedUtil.fontMono();
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

	function sketchWebgl() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas-webgl');
		var settings:Settings = new Settings(sketchWidth, sketchHeight, 'webgl');
		var sketch = Sketcher.create(settings).appendTo(elem);

		generateShapes(sketch);
	}

	function generateShapes(sketch:Sketcher) {
		// quick generate grid
		if (isDebug) {
			sketcher.debug.Grid.gridDots(sketch, grid);
		}

		for (i in 0...randomArray.length) {
			var randomRect = randomArray[i];
			var p = randomRect.point;
			var shape = sketch.makeRectangle(p.x, p.y, randomRect.width, randomRect.height, true);
			shape.setFill(randomRect.color);
			shape.setRotate(randomRect.rotation, p.x, p.y);
			var poly = sketch.makeX(p.x, p.y, 'black');
		}

		var t1 = sketch.makeText("1", (sketchWidth / 4) * 1, (sketchHeight / 4) * 1);
		t1.textAlign = TextAlignType.Center;
		t1.fontFamily = fontFamily;
		t1.fontSizePx = 60;

		var t1 = sketch.makeText("2", (sketchWidth / 4) * 3, (sketchHeight / 4) * 1);
		t1.textAlign = TextAlignType.Center;
		t1.fontFamily = fontFamily;
		t1.fontSizePx = 60;

		var t1 = sketch.makeText("3", (sketchWidth / 4) * 1, (sketchHeight / 4) * 3);
		t1.textAlign = TextAlignType.Center;
		t1.fontFamily = fontFamily;
		t1.fontSizePx = 60;

		var t1 = sketch.makeText("4", (sketchWidth / 4) * 3, (sketchHeight / 4) * 3);
		t1.textAlign = TextAlignType.Center;
		t1.fontFamily = fontFamily;
		t1.fontSizePx = 60;

		var mirror = sketch.makeMirror();

		// Don't forget to tell two to render everything to the screen
		sketch.update();
	}
}

typedef RandomRect = {
	@:optional var _id:String;
	var point:Point;
	var color:String;
	var rotation:Float;
	var width:Float;
	var height:Float;
}
