package;

import js.Browser.*;
// cc
import Sketch;
import cc.lets.Go;
import cc.util.GridUtil;
import cc.util.MathUtil.*;
import cc.AST;
import cc.util.ColorUtil.*;
import Sketch;

class Main {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			trace("Start Sketcher");
			init();
		});
	}

	function init() {
		// initDocument(); // if document doesn't have elements with correct id
		// sketchSVG();
		// sketchCanvas();
		// //
		// sketchRoundedRectSVG();
		// sketchRoundedRectCanvas();
		// //
		// sketchShapes();
		// // shape research
		// sketchDefaultShapes();
		// sketchDefaultShapesC(); // (canvas) wip
		// // animation
		// sketchAnimation();
		// sketchAnimationC();
		// // drips and spatter
		// sketchDrips();
		// sketchDripsC();
		// papertoys
		sketchPapertoys();
		sketchPapertoysC();
	}

	function initDocument() {
		var div0 = document.createDivElement();
		div0.id = 'sketcher-svg';
		var div1 = document.createDivElement();
		div1.id = 'sketcher-canvas';
		document.body.appendChild(div0);
		document.body.appendChild(div1);
	}

	function sketchPapertoys() {
		var size = 600; // instagram 1080
		var elem = document.getElementById('sketcher-svg-papertoys');
		var params:Settings = new Settings(size, size, 'svg');
		// params.autostart = true;
		params.padding = 0;
		params.scale = true;
		var sketch = Sketcher.create(params).appendTo(elem);

		var cellWidth = 100;
		var cellHeight = 100;

		var dashArray = [5];

		var cp:cc.Point = {x: Sketch.Global.w / 2, y: cellHeight * 1};
		var sq0 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq0.dash = dashArray;
		//
		var cp:cc.Point = {x: Sketch.Global.w / 2, y: cellHeight * 2};
		var sq1 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq1.dash = dashArray;

		var cp:cc.Point = {x: Sketch.Global.w / 2, y: cellHeight * 3};
		var sq2 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq2.dash = dashArray;

		var cp:cc.Point = {x: Sketch.Global.w / 2, y: cellHeight * 4};
		var sq3 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq3.dash = dashArray;

		// Cube left side
		var cp:cc.Point = {x: Sketch.Global.w / 2 - cellWidth, y: cellHeight * 3};
		var sq4 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq4.dash = dashArray;
		// sq4.id = 'cube left side';

		// cube right side, tab bottom
		var p1:cc.Point = {x: cp.x - (cellWidth / 2), y: cp.y + (cellHeight / 2)};
		var p2:cc.Point = {x: cp.x + (cellWidth / 2), y: cp.y + (cellHeight / 2)};
		var polyl0 = sketch.makePolygon(paperTab(p1, p2));
		var polyl1 = sketch.makePolygon(paperTab(p1, p2));
		polyl1.setRotate(90, cp.x, cp.y);
		var polyl2 = sketch.makePolygon(paperTab(p1, p2));
		polyl2.setPosition(0, -cellWidth);
		//
		// Cube right side
		var cp:cc.Point = {x: Sketch.Global.w / 2 + cellWidth, y: cellHeight * 3};
		var sq5 = sketch.makeRectangle(Math.round(cp.x), Math.round(cp.y), Math.round(cellWidth), Math.round(cellHeight));
		sq5.dash = dashArray;
		// cube right side, tab bottom
		var p1:cc.Point = {x: cp.x - (cellWidth / 2), y: cp.y + (cellHeight / 2)};
		var p2:cc.Point = {x: cp.x + (cellWidth / 2), y: cp.y + (cellHeight / 2)};
		var poly0 = sketch.makePolygon(paperTab(p1, p2));
		var poly1 = sketch.makePolygon(paperTab(p1, p2));
		poly1.setRotate(90, cp.x, cp.y);
		poly1.setPosition(0, -cellHeight);
		var poly2 = sketch.makePolygon(paperTab(p1, p2));
		poly2.setPosition(0, -cellHeight);
		// bottom tab
		var polybottom = sketch.makePolygon(paperTab(p1, p2));
		polybottom.id = 'bottom';
		polybottom.setPosition(-cellWidth, cellHeight);
		// var polyClone = poly.clone();
		// polyClone.setRotate(-90);

		var groupGlue = sketch.makeGroup([polyl0, polyl1, polyl2, poly0, poly1, poly2, polybottom]);
		groupGlue.id = 'cube glue';
		groupGlue.fill = getColourObj(GRAY);
		groupGlue.stroke = getColourObj(BLACK);
		// groupGlue.fill = getColourObj(PINK);
		// groupGlue.stroke = getColourObj(BLACK);
		// groupGlue.opacity = 0.1;

		//
		var group = sketch.makeGroup([sq0, sq1, sq2, sq3, sq4, sq5]);
		group.id = 'cube shape';
		group.fill = getColourObj(WHITE);
		group.stroke = getColourObj(BLACK);
		// group.opacity = 0.1;

		// draw
		sketch.update();

		// setElementClickDownload(elem);

		addDownloadElements(elem);
	}

	function addDownloadElements(elem:js.html.Element) {
		var el = document.createDivElement();
		el.id = "wrapper_download";
		el.className = 'btn-group';

		el.appendChild(btnCreator('jpg'));
		el.appendChild(btnCreator('png'));
		el.appendChild(btnCreator('svg'));

		elem.appendChild(el);
	}

	function btnCreator(id:String):js.html.AnchorElement {
		var anchor = document.createAnchorElement();
		anchor.setAttribute('download-id', '${id}');
		anchor.className = 'btn btn-dark btn-sm';
		anchor.href = '#${id}';
		anchor.onclick = testHandler;
		anchor.innerHTML = '${id} ';
		return anchor;
	}

	function testHandler(e:js.html.MouseEvent) {
		trace(' testhandler${e} ');
		trace(cast(e.currentTarget, js.html.AnchorElement).getAttribute('download-id'));
		var attr = cast(e.currentTarget, js.html.AnchorElement).getAttribute('download-id');
		var wrapperDiv = (cast(e.currentTarget, js.html.AnchorElement).parentElement.parentElement);
		var svg:js.html.svg.SVGElement = cast wrapperDiv.getElementsByTagName('svg')[0];
		var filename = '${wrapperDiv.id}_${Date.now().getTime()}';
		switch (attr) {
			case 'jpg':
				svg2Canvas(svg, true, filename);
			case 'png':
				svg2Canvas(svg, false, filename);
			case 'svg':
				downloadTextFile(svg.outerHTML, '${filename}.svg');
			default:
				trace("case '" + attr + "': trace ('" + attr + "');");
		}
	}

	function svg2Canvas(svg:js.html.svg.SVGElement, isJpg:Bool = true, filename:String) {
		var svgW = Std.parseInt(svg.getAttribute('width'));
		var svgH = Std.parseInt(svg.getAttribute('height'));

		var canvas = document.createCanvasElement();
		var ctx = canvas.getContext2d();
		canvas.width = svgW;
		canvas.height = svgH;

		var image = new js.html.Image();
		image.onload = function() {
			if (isJpg) {
				ctx.fillStyle = "white";
				ctx.fillRect(0, 0, canvas.width, canvas.height);
			}
			ctx.drawImage(image, 0, 0, svgW, svgH);
			cc.tool.ExportFile.downloadImageBg(ctx, isJpg, filename);
		}
		image.src = 'data:image/svg+xml,${svg.outerHTML}';
		// document.body.appendChild(canvas);
	}

	function paperTab(p1:cc.Point, p2:cc.Point):Array<Int> {
		var offset = Math.round(cc.model.constants.Paper.mm2pixel(7));
		var sideArr:Array<Int> = [
			Math.round(p1.x), Math.round(p1.y), Math.round(p1.x) + offset, Math.round(p1.y) + offset, Math.round(p2.x) - offset, Math.round(p2.y) + offset,
			Math.round(p2.x), Math.round(p2.y), Math.round(p2.x) - offset, Math.round(p2.y) - offset, Math.round(p1.x) + offset, Math.round(p1.y) - offset,
			Math.round(p1.x), Math.round(p1.y),
		];
		return sideArr;
	}

	function sketchPapertoysC() {
		var elem = document.getElementById(' sketcher - canvas - papertoys ');
	}

	function sketchDrips() {
		var size = 500; // instagram 1080
		var elem = document.getElementById(' sketcher - svg - drips ');
		var params:Settings = new Settings(size, size, ' svg ');
		// params.autostart = true;
		params.padding = 10;
		params.scale = true;
		var sketch = Sketcher.create(params).appendTo(elem);

		var grid:GridUtil = new GridUtil();
		grid.setIsCenterPoint(true);
		grid.setNumbered(3, 3);

		var circleRadius = 50;

		for (k in 0...grid.array.length) {
			// center point
			var cp:cc.Point = grid.array[k];
			sketch.makeX(Math.round(cp.x), Math.round(cp.y));

			// random biggest spatter
			var randomCircleRadius = random(circleRadius / 2, circleRadius);
			// for-ground
			var circle = sketch.makeCircle(Math.round(cp.x), Math.round(cp.y), Math.round(randomCircleRadius));
			circle.fill = ' black ';
			circle.noStroke();
			// border spatter
			for (i in 0...10) {
				var rp:cc.Point = {
					x: cp.x + random(-randomCircleRadius, randomCircleRadius),
					y: cp.y + random(-randomCircleRadius, randomCircleRadius)
				};
				var spatter = sketch.makeCircle(Math.round(rp.x), Math.round(rp.y), Math.round(random(randomCircleRadius / 2)));
				spatter.fill = rgb(0); // ' black ';
				spatter.noStroke();
			}
			// drip
			for (j in 0...3) {
				var dripWeight = randomInt(10, Math.round(randomCircleRadius / 2));
				var rp:cc.Point = {
					x: cp.x + random(-randomCircleRadius + dripWeight, randomCircleRadius - dripWeight),
					y: cp.y + random(-randomCircleRadius + dripWeight, randomCircleRadius - dripWeight)
				};
				// drip line, straight down
				var line = sketch.makeLine(Math.round(rp.x), Math.round(rp.y), Math.round(rp.x),
					Math.round(rp.y + random(randomCircleRadius, randomCircleRadius + 100)));
				line.lineCap = ' round '; // "butt|round|square";
				line.stroke = rgb(0);
				line.lineWeight = dripWeight;
			}
		}

		// draw
		sketch.update();
	}

	function sketchDripsC() {
		var elem = document.getElementById(' sketcher - canvas - drips ');
	}

	function sketchAnimation() {
		var elem = document.getElementById(' sketcher - svg - animation ');
		var params:Settings = new Settings(680, 200, ' svg ');
		var two = Sketcher.create(params).appendTo(elem);

		var rect = two.makeRectangle(50, 50, 50, 50);
		rect.id = ' animationObject ';

		// Don' t forget to tell two to render everything to the screen two.update();

		var temp = (document.getElementById('animationObject'));

		// trace(rect.toString());
		// trace(rect.toObject());

		// Go.to(rect, 1.5).x(600).prop('opacity', 0).onUpdate(onUpdateHandler, [1, 2, 3]).onComplete(onAnimateHandler, ['one', 'two', 'three']);
		// Go.to(rect,
		// 	1.5).x(600).prop('opacity',
		// 	0).onAnimationStart(onStartHandler, ['a', 'b', 'c']).onUpdate(onUpdateHandler, ['ones', 'two', 'three']).onComplete(onAnimateHandler, ['1', '2', '3']);

		var temp = rect.toObject();

		// Go.to(temp, 1.5).x(600).prop('opacity', 0).onUpdate(onUpdateHandler, [temp]).onComplete(onAnimateHandler, ['one', 'two', 'three']);
		Go.to(rect, 1.5).x(600).prop('opacity', 0).onComplete(onAnimateHandler, ['one', 'two', 'three']);

		var svgElement:js.html.svg.RectElement = cast(document.getElementById('animationObject'));
		// svgElement.
	};

	function onStartHandler(arr:Dynamic) {
		// console.log(arr);
		trace('onStartHandler: ' + arr.length, arr);
		var arrr:Array<Dynamic> = cast arr;
		trace('onStartHandler: ' + arrr.length, arrr);
		// trace('onStartHandler');
	}

	function onUpdateHandler(arr:Array<Dynamic>) {
		trace('onUpdateHandler: ' + arr.length, arr);
		// var svgElement:js.html.svg.RectElement = cast(document.getElementById('animationObject'));
		// var rect:draw.Rectangle = untyped arr;
		// svgElement.setAttribute('x', Std.string(rect.x));
		// svgElement.setAttribute('opacity', Std.string(rect.opacity));
	}

	function onAnimateHandler(arr:Array<Dynamic>) {
		trace('onAnimateHandler: ' + arr.length, arr);
		// trace('xxxxx');
	}

	function sketchAnimationC() {};

	function sketchDefaultShapes() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-defaultshapes');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		var arr = ['square', 'circle', 'line', 'rectangle', 'ellipse', 'polygon', 'group', 'text'];
		var xoffset = 80;
		for (i in 0...arr.length) {
			var xpos = 50 + (i * xoffset);
			var ypos = 180;
			var txt = two.makeText(arr[i], xpos, ypos);
			// txt.style = '';
			// see alignment
			var x = two.makeX(xpos, ypos);
		}
		// square

		var _x = 50 + (0 * xoffset);
		var _y = 100;
		var rect = two.makeRectangle(_x, _y, 50, 50);
		// rect.fill = '#fab1a0';
		// rect.stroke = '#ff7675'; // Accepts all valid css color
		var x = two.makeX(_x, _y);

		// circle
		var _x = 50 + (1 * xoffset);
		var circle = two.makeCircle(_x, _y, 25);
		// circle.fill = '#fab1a0';
		// circle.stroke = '#ff7675'; // Accepts all valid css color

		// line
		var _x1 = 50 + (2 * xoffset);
		var _x2 = 50 + (3 * xoffset);
		var _y1 = 100;
		var _y2 = 50;
		var line = two.makeLine(_x1, _y1, _x2, _y2);
		var x = two.makeX(_x1, _y1);
		var x = two.makeX(_x2, _y2);

		// rectangle
		var _x = 50 + (3 * xoffset);
		var rect = two.makeRectangle(_x, _y, 50, 100);
		rect.opacity = 0.5;
		rect.fill = '#fab1a0';
		rect.stroke = '#ff7675'; // Accepts all valid css color

		// ellipse
		var _x = 50 + (4 * xoffset);
		var ellipse = two.makeEllipse(_x, _y, 50, 20);

		// polygon
		var _x = 50 + (5 * xoffset);
		var poly = two.makePolygon([0, 100, 50, 25, 50, 75, 100, 0]);
		poly.id = 'bliksum';
		// poly.position(_x - 50, _y - 50);
		// poly.fill = '#fab1a0';
		// poly.stroke = '#ff7675'; // Accepts all valid css color

		// group
		var _x = 50 + (6 * xoffset);
		var circle1 = two.makeCircle(_x, _y + 10, 25);
		circle1.opacity = 0.5;
		var circle2 = two.makeCircle(_x, _y - 10, 25);
		circle2.opacity = 0.5;

		// Groups can take an array of shapes and/or groups.
		var group = two.makeGroup([circle1, circle2]);
		group.rotation = Math.PI;
		group.scale = 0.75;
		// text example

		var txt = two.makeText("Saira\nStencil\nOne", 50 + ((arr.length - 1) * xoffset), 100);
		txt.style = 'font-family: \'Saira Stencil One\', Arial, cursive; font-size: 50px; fill:red;';

		// set all x
		for (i in 0...arr.length) {
			var _x = 50 + (i * xoffset);
			// see registeration point (center point for shape)
			var x = two.makeX(_x, _y, 'green');
		}

		// var line = two.makeLine(0, 0, 100, 100);

		// Don't forget to tell two to render everything to the screen
		two.update();

		// setElementClickDownload(elem);
	}

	function setElementClickDownload(elem:js.html.Element) {
		if (elem != null) {
			// [mck] create an automate function for this, is element is null don't
			elem.onclick = function(e) {
				// trace(elem.innerHTML);
				downloadTextFile(elem.innerHTML, '${elem.id}_${Date.now().getTime()}.svg');
			};
		}
	}

	function sketchDefaultShapesC() {}

	function sketchShapes() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-shapes');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		var rect = two.makeRoundedRectangle(60, 100, 100, 100, 20);
		rect.fill = '#fab1a0';
		rect.stroke = '#ff7675'; // Accepts all valid css color
		rect.linewidth = 3;

		// var line = two.makeLine(0, 0, 100, 100);

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchRoundedRectSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg-roundedrect');
		var params:Settings = new Settings(680, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#74b9ff';
			rect.stroke = '#6c5ce7'; // Accepts all valid css color
			rect.linewidth = i;
		}

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchRoundedRectCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas-roundedrect');
		var params:Settings = new Settings(680, 200, 'canvas');
		var two = Sketcher.create(params).appendTo(elem);

		for (i in 0...6) {
			var offset = 110;
			var rect = two.makeRoundedRectangle(60 + (offset * i), 100, 100, 100, i * 10);
			rect.fill = '#74b9ff';
			rect.stroke = '#6c5ce7'; // Accepts all valid css color
			rect.linewidth = i;
		}

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchSVG() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-svg');
		var params:Settings = new Settings(285, 200, 'svg');
		var two = Sketcher.create(params).appendTo(elem);

		// two has convenience methods to create shapes.
		var circle = two.makeCircle(72, 100, 50);
		var rect = two.makeRectangle(213, 100, 100, 100);

		// The object returned has many stylable properties:
		circle.fill = '#FF8000';
		circle.stroke = 'orangered'; // Accepts all valid css color
		circle.linewidth = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.opacity = 0.75;
		rect.noStroke();

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	function sketchCanvas() {
		// Make an instance of two and place it on the page.
		var elem = document.getElementById('sketcher-canvas');
		var params:Settings = new Settings(285, 200, 'canvas');
		var two = Sketcher.create(params).appendTo(elem);

		// two has convenience methods to create shapes.
		var circle = two.makeCircle(72, 100, 50);
		var rect = two.makeRectangle(213, 100, 100, 100);

		// The object returned has many stylable properties:
		circle.fill = '#FF8000';
		circle.stroke = 'orangered'; // Accepts all valid css color
		circle.linewidth = 5;

		rect.fill = 'rgb(0, 200, 255)';
		rect.opacity = 0.75;
		rect.noStroke();

		// Don't forget to tell two to render everything to the screen
		two.update();
	}

	// ____________________________________ misc ____________________________________

	public static function downloadTextFile(text:String, ?fileName:String) {
		if (fileName == null)
			fileName = 'CC-txt-${Date.now().getTime()}.txt';

		var element = document.createElement('a');
		element.setAttribute('href', 'data:text/plain;charset=utf-8,' + untyped encodeURIComponent(text));
		element.setAttribute('download', fileName);

		element.style.display = 'none';
		document.body.appendChild(element);

		element.click();

		document.body.removeChild(element);
	}

	static function main() {
		var app = new Main();
	}
}
