package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;
import js.html.Image;
import js.Browser.*;

class Image extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'image'; // base (get class name?)

	// Points at a URL for the image file.
	@:isVar public var href(get, set):String;
	// The width the image renders at. Unlike HTML's <img>, this attribute is required.
	@:isVar public var width(get, set):Float;
	// he height the image renders at. Unlike HTML's <img>, this attribute is required.
	@:isVar public var height(get, set):Float;

	@:isVar public var preserveAspectRatio(get, set):PreserveAspectRatioObj;

	@:isVar public var isCenter(get, set):Bool;

	public function new(x, y, href, width, height, ?isCenter:Bool = false) {
		this.x = x;
		this.y = y;
		this.href = href;
		this.width = width;
		this.height = height;

		this.isCenter = isCenter;
		if (isCenter) {
			this.x = this.x - (this.width / 2);
			this.y = this.y - (this.height / 2);

			// trace(this.x);
		}

		super('image');
	}

	public function svg(?settings:Settings):String {
		xml.set('x', Std.string(this.x));
		xml.set('y', Std.string(this.y));
		xml.set('href', Std.string(this.href));
		xml.set('width', Std.string(this.width));
		xml.set('height', Std.string(this.height));

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		ctx.imageSmoothingEnabled = true; // default true
		untyped ctx.imageSmoothingQuality = 'high';
		// trace('canvas image');
		var img = new js.html.Image(); // Create new img element
		img.onload = function() {
			trace('image.onload');

			// execute drawImage statements here

			// trace(img.width); // 600
			// trace(img.height); // 529
			var prop = img.height / img.width;
			if (img.width < img.height)
				prop = img.width / img.height;

			// rotation & move...
			if (this.rotate != null) {
				// trace(this.x, this.y, this.rotate);
				ctx.save();

				ctx.translate(this.x, this.y);
				ctx.rotate(MathUtil.radians(this.rotate));

				if (this.move != null) {
					ctx.translate(this.move.x, this.move.y);
				}

				if (isCenter) {
					ctx.drawImage(img, -(this.width * 0), -(this.height * prop), this.width, this.height * prop);
				} else {
					ctx.drawImage(img, 0, 0, this.width, this.height * prop);
				}

				ctx.restore();
			}
			if (this.rotate == null) {
				ctx.drawImage(img, this.x, this.y, this.width, this.height * prop);
			}
		};
		img.onerror = function(e) {
			console.warn(e);
		}
		// img.crossOrigin = "Anonymous"; ???
		img.src = this.href; // Set source path

		// trace(this.href, this.width, this.height);

		// var testImg = document.createImageElement();
		// testImg.src = this.href;
		// document.body.appendChild(testImg);
	}

	// ____________________________________ getter/setter ____________________________________

	function get_href():String {
		return href;
	}

	function set_href(value:String):String {
		return href = value;
	}

	function get_width():Float {
		return width;
	}

	function set_width(value:Float):Float {
		return width = value;
	}

	function get_height():Float {
		return height;
	}

	function set_height(value:Float):Float {
		return height = value;
	}

	function get_isCenter():Bool {
		return isCenter;
	}

	function set_isCenter(value:Bool):Bool {
		return isCenter = value;
	}

	function get_preserveAspectRatio():PreserveAspectRatioObj {
		return preserveAspectRatio;
	}

	function set_preserveAspectRatio(value:PreserveAspectRatioObj):PreserveAspectRatioObj {
		return preserveAspectRatio = value;
	}
}

// https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/preserveAspectRatio
enum abstract PreserveAspectRatioObj(String) {
	var None = "none"; // Do not force uniform scaling. Scale the graphic content of the given element non-uniformly if necessary such that the element's bounding box exactly matches the viewport rectangle. Note that if <align> is none, then the optional <meetOrSlice> value is ignored.
	var xMinYMin = "xMinYMin"; // - Force uniform scaling.
	// Align the <min-x> of the element's viewBox with the smallest X value of the viewport.
	//  Align the <min-y> of the element's viewBox with the smallest Y value of the viewport.
	var xMidYMin = "xMidYMin"; // - Force uniform scaling.
	// Align the midpoint X value of the element's viewBox with the midpoint X value of the viewport.
	// Align the <min-y> of the element's viewBox with the smallest Y value of the viewport.
	var xMaxYMin = "xMaxYMin"; // - Force uniform scaling.
	// Align the <min-x>+<width> of the element's viewBox with the maximum X value of the viewport.
	// Align the <min-y> of the element's viewBox with the smallest Y value of the viewport.
	var xMinYMid = "xMinYMid"; // - Force uniform scaling.
	// Align the <min-x> of the element's viewBox with the smallest X value of the viewport.
	// Align the midpoint Y value of the element's viewBox with the midpoint Y value of the viewport.
	var xMidYMid = "xMidYMid"; // (the default)  // - Force uniform scaling.
	// Align the midpoint X value of the element's viewBox with the midpoint X value of the viewport.
	// Align the midpoint Y value of the element's viewBox with the midpoint Y value of the viewport.
	var xMaxYMid = "xMaxYMid"; // - Force uniform scaling. // Align the <min-x>+<width> of the element's viewBox with the maximum X value of the viewport.
	// Align the midpoint Y value of the element's viewBox with the midpoint Y value of the viewport.
	var xMinYMax = "xMinYMax"; // - Force uniform scaling. // Align the <min-x> of the element's viewBox with the smallest X value of the viewport.
	// Align the <min-y>+<height> of the element's viewBox with the maximum Y value of the viewport.
	var xMidYMax = "xMidYMax"; // - Force uniform scaling. // Align the midpoint X value of the element's viewBox with the midpoint X value of the viewport.
	// Align the <min-y>+<height> of the element's viewBox with the maximum Y value of the viewport.
	var xMaxYMax = "xMaxYMax"; //  // - Force uniform scaling.
	// Align the <min-x>+<width> of the element's viewBox with the maximum X value of the viewport.
	// Align the <min-y>+<height> of the element's viewBox with the maximum Y value of the viewport.
}
