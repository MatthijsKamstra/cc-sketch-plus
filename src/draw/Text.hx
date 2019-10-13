package draw;

import js.Browser.*;

using StringTools;

class Text extends Base implements IBase {
	@:isVar public var str(get, set):String;

	@:isVar public var fontSize(get, set):String;
	@:isVar public var fontFamily(get, set):String;

	@:isVar public var fontWeight(get, set):String;

	@:isVar public var textAnchor(get, set):String;

	@:isVar public var alignmentBaseline(get, set):String;

	/**
	 * test style
	 */
	@:isVar public var style(get, set):String;

	public var type = 'Text'; // base (get class name?)

	/**
	 *
	 * [Description]
	 * @param str
	 * @param x
	 * @param y
	 * @source: https://developer.mozilla.org/en-US/docs/Web/SVG/Element/text
	 */
	public function new(str:String, ?x:Float, ?y:Float) {
		this.str = str;
		this.x = x;
		this.y = y;
		super('text');
	}

	// ____________________________________ func ____________________________________
	public function align(value:String) {
		this.textAnchor = value;
	}

	public function baseline(value:String) {
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
		trace("needs work!");
		// ctx.beginPath();
		// ctx.fill();
		// ctx.stroke();
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

	function get_textAnchor():String {
		return textAnchor;
	}

	function set_textAnchor(value:String):String {
		xml.set('text-anchor', value);
		return textAnchor = value;
	}

	function get_alignmentBaseline():String {
		return alignmentBaseline;
	}

	function set_alignmentBaseline(value:String):String {
		xml.set('alignment-baseline', value);
		xml.set('dominant-baseline', value);
		return alignmentBaseline = value;
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
