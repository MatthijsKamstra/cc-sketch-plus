package util;

import Sketch.Global.*;
import js.Browser.*;
import js.html.*;
import js.html.MouseEvent;
import js.html.CanvasElement;
import cc.tool.ExportFile;
import cc.model.constants.Paper.*;

using StringTools;

class TextUtil {
	var svg:js.html.svg.SVGElement = null;

	var svgNS = "http://www.w3.org/2000/svg";

	public var fontFamily:String;
	public var fontWeight:String;
	public var fontSize:Float;

	public function new() {
		createSVG();
	}

	public function createSVG() {
		var ID = 'hidden-div-svg-wrapper';
		var SVG_ID = 'temp-svg-wrapper';
		var div:js.html.DivElement;
		if (document.getElementById(ID) == null) {
			div = document.createDivElement();
			div.id = ID;
			div.className = "hidden svg-hidden";
			document.body.appendChild(div);
		} else {
			div = cast document.getElementById(ID);
		}
		if (document.getElementById(SVG_ID) == null) {
			// create the svg element
			svg = cast document.createElementNS(svgNS, "svg");
			svg.id = SVG_ID;
			svg.setAttribute('xmlns', svgNS);

			var paperW = Math.ceil(mm2pixel(210));

			// set width and height
			svg.setAttribute("width", '${paperW}');
			svg.setAttribute("height", "100");

			// create a circle
			// var cir1 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
			// cir1.setAttribute("cx", "80");
			// cir1.setAttribute("cy", "80");
			// cir1.setAttribute("r", "30");
			// cir1.setAttribute("fill", "red");

			// attach it to the container
			// svg.appendChild(cir1);

			// attach container to document
			div.appendChild(svg);
			// document.getElementById(ID).appendChild(svg);
		} else {
			svg = cast document.getElementById(SVG_ID);
		}
	}

	// https://stackoverflow.com/questions/23142350/proper-way-to-calculate-the-height-and-width-of-a-svg-text
	// public function bboxText(str:String, size:Float) {
	// 	trace(str, size);
	// 	var _x = 0; // size * 1.5;
	// 	var _y = 0; // size * 1.5;
	// 	// var _x = size * 1.5;
	// 	// var _y = size * 1.5;
	// 	var data = document.createTextNode(str);
	// 	var svgElement = document.createElementNS(svgNS, "text");
	// 	svgElement.setAttribute("x", '${_x}');
	// 	svgElement.setAttribute("y", '${_y}');
	// 	svgElement.setAttribute("font-family", '\'Oswald\', sans-serif');
	// 	svgElement.setAttribute("font-weight", "700"); // 299/300/400/500/600/700
	// 	svgElement.setAttribute("font-size", '${size}px');
	// 	svgElement.appendChild(data);
	// 	svg.appendChild(svgElement);
	// 	var bbox:js.html.svg.Rect = untyped svgElement.getBBox();
	// 	console.log(bbox);
	// 	// svgElement.parentNode.removeChild(svgElement);
	// 	// return bbox;
	// 	var rect = document.createElementNS(svgNS, 'rect');
	// 	rect.setAttribute('x', '${bbox.x}');
	// 	rect.setAttribute('y', '${bbox.y}');
	// 	rect.setAttribute('height', '${bbox.height}');
	// 	rect.setAttribute('width', '${bbox.width}');
	// 	rect.setAttribute('fill', 'green');
	// 	rect.setAttribute('stroke', '#ff3333');
	// 	rect.setAttribute('fill-opacity', '0');
	// 	svg.appendChild(rect);
	// }

	/**
	 * Get the bbox of a string
	 *
	 * @example
	 * 		var textUtil = new util.TextUtil();
	 *		textUtil.fontFamily = _fontFamilie;
	 *		textUtil.fontWeight = _fontWeight;
	 *		textUtil.fontSize = _fontSize;
	 *		// var _fontSize:Float = textUtil.getFittext(value, _maxW);
	 * 		var rect : js.html.svg.Rect = textUtil.getBboxText(value);
	 *
	 * @param str 	value to get the rect grom
	 * @return js.html.svg.Rect
	 */
	public function getBboxText(str:String):js.html.svg.Rect {
		// trace(str, size);

		var _x = 0;
		var _y = 0;

		var data = document.createTextNode(str);
		var svgElement = document.createElementNS(svgNS, "text");
		svgElement.setAttribute("x", '${_x}');
		svgElement.setAttribute("y", '${_y}');
		svgElement.setAttribute("font-family", fontFamily);
		svgElement.setAttribute("font-weight", fontWeight); // 200/300/400/500/600/700
		svgElement.setAttribute("font-size", '${fontSize}px');
		svgElement.appendChild(data);
		svg.appendChild(svgElement);

		var bbox:js.html.svg.Rect = untyped svgElement.getBBox();

		svgElement.parentNode.removeChild(svgElement); // remove again

		return bbox;
	}

	/**
	 * I need to change it to a value I will use... but
	 * @param txt
	 */
	// public function test(txt:Dynamic) {
	// 	var text = new draw.Text("hell", 0, 20);
	// 	// text. // trace(text.svg());
	// 	var node = document.createRange().createContextualFragment(text.svg());
	// 	// var node = document.createElementNS(svgNS, text.svg());
	// 	// node.setAttribute('xmlns', svgNS);
	// 	svg.appendChild(node);
	// }

	/**
	 *
	 * calculate the with of the characters, and create an array of words
	 *
	 * Note:
	 * 	- important to have a example text in the canvas, otherwise the measurement don't work
	 * 	- important to have the font loaded
	 *
	 * @source	 https://stackoverflow.com/questions/2936112/text-wrap-in-a-canvas-element
	 *
	 * @example
	 *
	 * 		var lines:Array<String> = TextUtil.getLines(ctx, text, square - (2 * _padding));
	 * 		for (i in 0...lines.length) {
	 * 			var line = lines[i];
	 * 		}
	 *
	 * @param ctx
	 * @param text
	 * @param maxWidth
	 */
	public function getLines(text:String, maxWidth:Float):Array<String> {
		// trace('$text, $maxWidth');

		var isDebug = false;

		// [mck] make sure that all lines are with \n included
		var _text = text.replace('\n', " \n ").replace("  ", " "); // make sure `\n` is seperated from the rest of the words
		var words:Array<String> = _text.split(" ");
		var lines:Array<String> = [];
		var currentLine = words[0];

		for (i in 1...words.length) {
			// for (var i = 1; i < words.length; i++) {
			var word = words[i];
			if (word == "\n") {
				lines.push(currentLine.trim()); // Removes leading and trailing space characters
				currentLine = "";
				continue;
			}
			var _text = currentLine + " " + word;
			var bbox:js.html.svg.Rect = getBboxText(_text);
			var width = getBboxText(_text).width;

			if (isDebug)
				trace('"${_text}".width: ${width} / ${maxWidth}');

			if (width < maxWidth) {
				currentLine += " " + word;
			} else {
				lines.push(currentLine.trim()); // Removes leading and trailing space characters
				if (word == " ") {
					currentLine = "";
				} else {
					currentLine = word;
				}
			}
		}
		lines.push(currentLine.trim());
		return lines;
	}

	/**
	 * @example
	 * 		var textUtil = new util.TextUtil();
	 *		textUtil.fontFamily = _fontFamilie;
	 *		textUtil.fontWeight = _fontWeight;
	 *		var _fontSize:Float = textUtil.getFittext(value, _maxW);
	 *
	 * @param str
	 * @param maxWidth
	 * @return Float
	 */
	public function getFittext(str:String, maxWidth:Float):Float {
		var _text = str;
		fontSize = 10;
		for (i in 0...100) {
			fontSize++;
			var bbox:js.html.svg.Rect = getBboxText(_text);
			var width = getBboxText(_text).width;
			if (width >= maxWidth) {
				break;
			}
		}
		return fontSize;
	}
}
