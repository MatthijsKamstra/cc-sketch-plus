package;

import sketcher.util.MathUtil;
import sketcher.draw.*;

class SketcherSVG extends SketcherCore {


	// id for containers
	public var CANVAS_ID:String = "sketcher_canvas";
	public var WEBGL_ID:String = "sketcher_canvas_webgl";
	public var SVG_ID:String = "sketcher_svg";
	public var WRAPPER_ID:String = "sketcher_wrapper";

	public static var UNIQ_ID:String = "";
	public static var SVG_UNIQ_ID:String = "";

	/**
	 * Create sketcher
	 *
	 * @example
	 * 		var settings = new Settings(paperW, paperH, 'svg');
	 *		settings.autostart = true;
	 *		settings.padding = 10;
	 *		settings.scale = false;
	 *		settings.elementID = 'sketcher-svg-wrapper';
	 *
	 *		var sketch2 = Sketcher.create(settings).appendTo(div0);
	 *
	 * @param settings
	 */
	public function new(settings:Settings) {
		this.settings = settings;

		Globals.Globals.w = settings.width;
		Globals.Globals.h = settings.height;
		Globals.Globals.w2 = settings.width / 2;
		Globals.Globals.h2 = settings.height / 2;

		// make sure the svg id is 'uniq'
		var u = Date.now().getTime();
		if ('$u' == UNIQ_ID) {
			UNIQ_ID = '${u}_1';
		} else {
			UNIQ_ID = '${u}';
		}
		SVG_UNIQ_ID = '${WRAPPER_ID}_${SVG_ID}_${UNIQ_ID}';
	}

	/**
	 * [Description]
	 * @param element
	 * @return SketcherSVG
	 */
	public function setup():SketcherSVG {
		// trace('appendto - svg');
		var svgW = '${settings.width}';
		var svgH = '${settings.height}';
		var svgViewBox = '0 0 ${settings.width} ${settings.height}';
		if (settings.sizeType != null) {
			svgW = '${Math.round(MathUtil.px2mm(settings.width))}${settings.sizeType}';
			svgH = '${Math.round(MathUtil.px2mm(settings.height))}${settings.sizeType}';
		}
		if (settings.viewBox != null) {
			svgViewBox = '${settings.viewBox[0]} ${settings.viewBox[1]} ${settings.viewBox[2]} ${settings.viewBox[3]}';
		}

		var _xml = '<?xml version="1.0" standalone="no"?><svg width="${svgW}" height="${svgH}" viewBox="${svgViewBox}" version="1.1" id="${SVG_UNIQ_ID}" xmlns="http://www.w3.org/2000/svg" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"></svg>';
		// element.innerHTML = (_xml);

		return this;
	}

	// [mck] TODO create settings AST to have possible object send as well?
	public static function create(settings:Settings):SketcherSVG {
		var sketcher = new SketcherSVG(settings);
		sketcher.baseArray = []; // make sure it's empty
		return sketcher;
	}

	// ____________________________________ update ____________________________________

	/**
	 * svg will be generated in array and objects
	 *
	 * So to generate the svg, you need to update it!
	 */
	public function update() {
		// trace('svg');
		// [mck] TODO change string into XML!!!
		var svgW = '${settings.width}';
		var svgH = '${settings.height}';
		var svgViewBox = '0 0 ${settings.width} ${settings.height}';
		if (settings.sizeType != null) {
			svgW += '${settings.sizeType}';
			svgH += '${settings.sizeType}';
		}
		if (settings.viewBox != null) {
			svgViewBox = '${settings.viewBox[0]} ${settings.viewBox[1]} ${settings.viewBox[2]} ${settings.viewBox[3]}';
		}

		var _xml = '<?xml version="1.0" standalone="no"?><svg width="${svgW}" height="${svgH}" viewBox="${svgViewBox}" version="1.1" id="${SVG_UNIQ_ID}" xmlns="http://www.w3.org/2000/svg" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape">';
		var svgInnerHtml = '';
		var content = '';
		var defs = '';
		for (i in 0...baseArray.length) {
			var base = baseArray[i];

			if (base == null)
				continue; // with the creation of groups there are base == null

			// if (base.type == 'Group') {
			// 	trace('groups do this');
			// 	cast(base, draw.Group).test();
			// }
			var draw = base.svg(settings);
			// trace(base.toString());
			// trace(draw);

			switch (base.type) {
				case 'gradient', 'mask', 'marker':
					defs += draw;
				default:
					content += draw;
			}

			// if (base.type == 'gradient') {
			// 	defs += draw;
			// } else {
			// 	content += draw;
			// }
		}
		_xml += '<defs>' + defs + '</defs>';
		_xml += content + '</svg>';

		svgInnerHtml += '<defs>' + defs + '</defs>';
		svgInnerHtml += content + '</svg>';

		var svg = _xml; // external acces?

		// if (this.getSVGElement() != null) {
		// 	this.getSVGElement().innerHTML = svgInnerHtml;
		// } else {
		// 	element.innerHTML = _xml;
		// }
		// [mck] not sure I want to reset it, but currently this is not usefull, only for animations
		// // empty baseArray
		// baseArray = [];

		return svg;
	}
}
