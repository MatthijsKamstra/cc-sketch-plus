package sketcher.draw;

import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;
#if js
import js.html.Image;
import js.Browser.*;
#end

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

	//  var image = sketch.makeImageFromImage(p.x, p.y, IMAGE, 100, 100, true);
	#if js
	@:isVar public var image(get, set):js.html.Image;
	#end

	public function new(x, y, href, width, height, ?isCenter:Bool = false) {
		this.x = x;
		this.y = y;
		this.href = href;
		this.width = width;
		this.height = height;

		this.isCenter = isCenter;
		// if (isCenter) {
		// 	this.x = this.x - (this.width / 2);
		// 	this.y = this.y - (this.height / 2);
		// 	// trace(this.x);

		// 	// todo canvas might not work this way
		// }
		super('image');
	}

	public function svg(?settings:Settings):String {
		if (isCenter) {
			this.x = this.x - (this.width / 2);
			this.y = this.y - (this.height / 2);
		}
		xml.set('x', Std.string(this.x));
		xml.set('y', Std.string(this.y));
		if (href != '') {
			xml.set('href', Std.string(this.href));
		} else {
			// trace('fixme');
			// trace(image);
			#if js
			xml.set('href', Std.string(image.src));
			#end
		}
		xml.set('width', Std.string(this.width));
		xml.set('height', Std.string(this.height));

		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}

		return xml.toString();
	}

	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		ctx.imageSmoothingEnabled = true; // default true
		untyped ctx.imageSmoothingQuality = 'high';
		// trace('canvas image ${this.id}');
		var img = new js.html.Image(); // Create new img element
		img.onload = function() {
			// trace('image.onload');

			// execute drawImage statements here

			canvasImage(ctx, img);

			// trace(img);
		};
		img.onerror = function(e) {
			console.warn(e);
		}
		// img.crossOrigin = "Anonymous"; ???
		if (this.href == '') {
			img = image;
			canvasImage(ctx, img);
		} else {
			img.src = this.href; // Set source path
		}

		// trace(this.href, this.width, this.height);

		// var testImg = document.createImageElement();
		// testImg.src = this.href;
		// document.body.appendChild(testImg);
	}

	private function canvasImage(ctx:js.html.CanvasRenderingContext2D, img:js.html.Image) {
		// trace(img.width); // 600
		// trace(img.height); // 529
		var ratio = img.height / img.width;
		// if (img.width < img.height)
		// ratio = img.width / img.height;

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
				ctx.drawImage(img, -(this.width * 0), -(this.height * ratio), this.width, this.height * ratio);
			} else {
				ctx.drawImage(img, 0, 0, this.width, this.height * ratio);
			}

			ctx.restore();
		}
		if (this.rotate == null) {
			// ctx.drawImage(img, this.x, this.y, this.width, this.height * ratio);
			// ctx.drawImage(img, this.x, this.y, this.width, this.height * ratio);

			if (isCenter) {
				// trace('${get_id()}');
				this.x = this.x - (this.width / 2);
				this.y = this.y - ((this.height * ratio) / 2);

				ctx.drawImage(img, this.x, this.y, this.width, this.height * ratio);

				// ctx.drawImage(img, 0, 0, this.width, this.height * ratio);

				// ctx.drawImage(img, this.x - (img.width / 2), this.y - (img.height / 2), this.width, this.height * ratio);
				// ctx.drawImage(img, -(this.width * 0), -(this.height * ratio), this.width, this.height * ratio);
			} else {
				ctx.drawImage(img, this.x, this.y, this.width, this.height * ratio);
				// ctx.drawImage(img, 0, 0, this.width, this.height * ratio);
			}
		}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

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

	#if js
	function get_image():js.html.Image {
		return image;
	}

	function set_image(value:js.html.Image):js.html.Image {
		return image = value;
	}
	#end

	function get_preserveAspectRatio():PreserveAspectRatioObj {
		return preserveAspectRatio;
	}

	function set_preserveAspectRatio(value:PreserveAspectRatioObj):PreserveAspectRatioObj {
		return preserveAspectRatio = value;
	}
} // https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/preserveAspectRatio

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
