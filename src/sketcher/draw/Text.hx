package sketcher.draw;

import js.Browser.*;
import sketcher.util.ColorUtil;

using StringTools;

/**
 * 	// description
 *	var text = sketch.makeText(this.shapeName, 50, 140);
 *	text.fontFamily = '"Soft Sugar [plain]", SOFTSUGARPLAIN, sans-serif';
 *	text.fontSize = '115px';
 *	text.fill = '#CCCCCC';
 *
 *	text.fontWeight = "700";
 *	text.fontSize = '${_fontSize}px';
 *	text.fill = getColourObj(BLACK);
 */
class Text extends draw.Base implements draw.IBase {
	public static var ISWARN:Bool;

	public var type = 'Text'; // base (get class name?)

	@:isVar public var str(get, set):String;

	@:isVar public var fontSize(get, set):String;

	/**
	 * font-family: family-name|generic-family|initial|inherit;
	 * @see https://www.w3schools.com/cssref/pr_font_font-family.asp
	 *
	 * @example '"Times New Roman", Times, serif;'
	 */
	@:isVar public var fontFamily(get, set):String;

	/**
	 * font-weight: normal|bold|bolder|lighter|number|initial|inherit;
	 * @see https://www.w3schools.com/cssref/pr_font_weight.asp
	 */
	@:isVar public var fontWeight(get, set):String;

	@:isVar public var textAnchor(get, set):TextAnchorType;

	@:isVar public var textAlign(get, set):TextAlignType;

	/**
	 * alignment-baseline: auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical | inherit
	 * @see https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/alignment-baseline
	 */
	@:isVar public var alignmentBaseline(get, set):AlignmentBaselineType;

	@:isVar public var dominantBaseline(get, set):DominantBaselineType;

	/**
	 * hacky
	 */
	public var _textAlign:String;

	public var _textBaseline:String;

	/**
	 * test style
	 */
	@:isVar public var style(get, set):String;

	/**
	 * Create a text element in svg
	 *
	 * @param str		string value
	 * @param x			(optional:default=0) x pos
	 * @param y			(optional:default=0) y pos
	 *
	 * @source: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/text
	 */
	public function new(str:String, ?x:Float = 0, ?y:Float = 0) {
		this.str = str;
		this.x = x;
		this.y = y;
		super('text');
	}

	// ____________________________________ func ____________________________________
	public function align(value:TextAnchorType) {
		this.textAnchor = value;
	}

	public function baseline(value:AlignmentBaselineType) {
		this.alignmentBaseline = value;
	}

	//  dominant-baseline="middle" text-anchor="middle"
	// ____________________________________ create ____________________________________
	public function svg(?settings:Settings):String {
		// var style = '<style>.small {font:italic 13px sans-serif; fill:red;}</style>';
		var comment = Xml.createComment('${this.str}');
		var content = Xml.parse(this.str);

		xml.addChild(comment); // strange reason I need to add this comment first otherwise the next line will not work
		xml.addChild(content);
		xml.set('x', Std.string(this.x));
		xml.set('y', Std.string(this.y));
		// this is probably a very bad way of fixing this... but it seems to work
		if (this.style != null) {
			// make sure the styling class is unique...
			var className = this.str.replace(' ', '').replace('\n', '').toLowerCase();
			xml.set('class', 'fontstyle_${className}');
			// var style = '<style type="text/css">.fontstyle_${className} {${this.style}}</style>';
			// xml.addChild(Xml.parse(style));

			// [mck] this doesn't break the svg export to jpg or png, but it doesn't show it in the canvas when rendering
			var style = document.createElement('style');
			style.innerHTML = '.fontstyle_${className} {${this.style}}';
			document.body.appendChild(style);

			// var _svg:js.html.svg.SVGElement = document.getElementsByName('svg')[0];
			// _svg.insertBefore(_svg.firstChild, style);
		}
		// xml.set('dx', Std.string(this.y));
		// xml.set('dy', Std.string(this.y));
		// xml.set('rotate', Std.string(this.y));
		// xml.set('lengthAdjust', Std.string(this.y));
		// xml.set('textLength', Std.string(this.y));

		if (this._textAlign != null) {
			convertTextAlign();
		}
		if (this._textBaseline != null) {
			convertTextBaseline();
		}

		/**
			<style>
			 .small { font: italic 13px sans-serif; }
			</style>
		 */

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		useDefaultsCanvas();

		ctx.save(); // save current state

		var _fillColor = ColorUtil.assumption(this.fillColor);
		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);

		var _css = '';
		ctx.font = '${_css} ${this.fontSize}px ${this.fontFamily}'.ltrim();
		ctx.textAlign = cast textAlign;
		ctx.textBaseline = cast alignmentBaseline;

		// trace(textAlign, alignmentBaseline);
		ctx.fillText(this.str, this.x, this.y);

		// restore canvas to previous position
		ctx.restore();
	}

	function convertTextAlign() {
		switch (this._textAlign) {
			case 'left':
				this.textAnchor = TextAnchorType.Left;
			case 'right':
				this.textAnchor = TextAnchorType.Right;
			default:
				this.textAnchor = TextAnchorType.Left;
				trace("case '" + this._textAlign + "': trace ('" + this._textAlign + "');");
		}
	}

	function convertTextBaseline() {
		switch (this._textBaseline) {
			case 'top':
				this.dominantBaseline = DominantBaselineType.Hanging;
			case 'center':
				this.dominantBaseline = DominantBaselineType.Middle;
			case 'bottom':
				this.dominantBaseline = DominantBaselineType.Baseline;
			default:
				this.dominantBaseline = DominantBaselineType.Auto;
				trace("case '" + this._textBaseline + "': trace ('" + this._textBaseline + "');");
		}
	}

	// ____________________________________ getter/setter ____________________________________

	function get_fontSize():String {
		return fontSize;
	}

	function set_fontSize(value:String):String {
		xml.set('font-size', value);
		return fontSize = value;
	}

	function get_fontFamily():String {
		return fontFamily;
	}

	function set_fontFamily(value:String):String {
		xml.set('font-family', value);
		return fontFamily = value;
	}

	function get_fontWeight():String {
		return fontWeight;
	}

	function set_fontWeight(value:String):String {
		xml.set('font-weight', value);
		return fontWeight = value;
	}

	function get_textAnchor():TextAnchorType {
		return textAnchor;
	}

	function set_textAnchor(value:TextAnchorType):TextAnchorType {
		xml.set('text-anchor', Std.string(value));
		return textAnchor = value;
	}

	function get_alignmentBaseline():AlignmentBaselineType {
		return alignmentBaseline;
	}

	function set_alignmentBaseline(value:AlignmentBaselineType):AlignmentBaselineType {
		xml.set('alignment-baseline', Std.string(value));
		return alignmentBaseline = value;
	}

	function get_dominantBaseline():DominantBaselineType {
		return dominantBaseline;
	}

	function set_dominantBaseline(value:DominantBaselineType):DominantBaselineType {
		xml.set('dominant-baseline', Std.string(value));
		return dominantBaseline = value;
	}

	function get_textAlign():TextAlignType {
		return textAlign;
	}

	function set_textAlign(value:TextAlignType):TextAlignType {
		return textAlign = value;
	}

	function get_str():String {
		return str;
	}

	function set_str(value:String):String {
		return str = value;
	}

	/**
	 * test
	 * @return String
	 */
	function get_style():String {
		return style;
	}

	function set_style(value:String):String {
		return style = value;
	}
}

@:enum abstract TextAnchorType(String) {
	var Start = "start";
	var Middle = "middle";
	var End = "end";
	var Left = "start"; // syntatic sugar
	var Right = "end"; // syntatic sugar
	var Center = "middle"; // syntatic sugar
}

@:enum abstract AlignmentBaselineType(String) {
	var Auto = "auto";
	var Baseline = "baseline";
	var BeforeEdge = "before-edge";
	var TextBeforeEdge = "text-before-edge";
	var Middle = "middle";
	var Central = "central";
	var AfterEdge = "after-edge";
	var TextAfterEdge = "text-after-edge";
	var Ideographic = "ideographic";
	var Alphabetic = "alphabetic";
	var Hanging = "hanging";
	var Mathematical = "mathematical";
	var Top = "top";
	var Center = "center";
	var Bottom = "bottom";
}

@:enum abstract DominantBaselineType(String) { // var Auto = "auto";
	var Auto = "auto";
	var Baseline = "baseline";
	var UseScript = 'use-script';
	var NoChange = 'no-change';
	var ResetSize = 'reset-size';
	var Ideographic = "ideographic";
	var Alphabetic = "alphabetic";
	var Hanging = "hanging";
	var Mathematical = "mathematical";
	var Central = 'central';
	var Middle = "middle";
	var TextAfterEdge = "text-after-edge";
	var TextBeforeEdge = "text-before-edge";
	var Inherit = 'inherit';
}

// canvas?
enum abstract TextAlignType(String) {
	var Center = "center";
	var End = "end";
	var Left = "left";
	var Right = "right";
	var Start = "start";
}