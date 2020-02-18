package sketcher.draw;

import sketcher.util.MathUtil;
import js.Browser.*;

class Group extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'group'; // base (get class name?)

	@:isVar public var arr(get, set):Array<IBase>;

	/**
	 * create a group to join a couple of IBase items
	 * useful in `svg`, not so much in `canvas`
	 * might be usefull to push all actions into one transform
	 */
	public function new(arr:Array<IBase>) {
		this.arr = arr;
		super('g');
	}

	public function svg(?settings:Settings):String {
		if (this.x > 0 && this.y > 0) {
			this.transArr.push('translate(${this.x}, ${this.y})');
		}
		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}
		// xml.set('x', Std.string(this.x));
		// xml.set('y', Std.string(this.y));

		var comment = Xml.createComment('Group: ${id}');
		xml.addChild(comment); // not sure why?
		xml.addChild(Xml.parse('<desc>${id}</desc>'));
		for (i in 0...this.arr.length) {
			// untyped xml.appendChild(this.arr[i].svg);
			// xml.addChild(Xml.createComment(this.arr[i].type));
			var base = this.arr[i];
			xml.addChild(Xml.parse(base.svg(null)));
		}
		// xml.set('x', '0');
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.groupCollapsed('Group (${id}) info canvas');
			console.info('the following work\n- strokeOpacity\n- fillOpacity\n- fillColor\n- strokeColor\n- strokeWeight');
			console.warn('doesn\'t work\n- rotate\n- move');
			console.groupEnd();
			Group.ISWARN = true;
		}
		// set everything to default values
		// useDefaultsCanvas();

		// TODO set transforms on group also on individuals
		for (i in 0...this.arr.length) {
			var base = this.arr[i];
			if (base == null)
				continue;

			// override the original values if the are not set
			if (this.fillOpacity != null) {
				cast(base, Base).fillOpacity = this.fillOpacity;
			}
			if (this.strokeOpacity != null) {
				cast(base, Base).strokeOpacity = this.strokeOpacity;
			}
			if (this.fillColor != null) {
				cast(base, Base).fillColor = this.fillColor;
			}
			if (this.strokeColor != null) {
				cast(base, Base).strokeColor = this.strokeColor;
			}
			if (this.strokeWeight != null) {
				cast(base, Base).strokeWeight = this.strokeWeight;
			}

			/*
				if (this.rotate != null) {
					var __w = ctx.canvas.width;
					var __h = ctx.canvas.height;

					var image = new js.html.Image();
					image.src = ctx.canvas.toDataURL("image/png");

					trace(__w, __h);
					trace(image);
					trace(this.rx, this.ry);

					// ctx.clearRect(0, 0, __w, __h);

					// save the unrotated context of the canvas so we can restore it later
					// the alternative is to untranslate & unrotate after drawing
					ctx.save();
					// move to the center of the canvas
					ctx.translate(this.rx, this.ry);
					// rotate the canvas to the specified degrees
					ctx.rotate(MathUtil.radians(this.rotate));
					// draw the image
					// since the context is rotated, the image will be rotated also
					// ctx.drawImage(image, -image.width / 2, -image.width / 2);

					cast(base, Base).x = 0;
					cast(base, Base).y = 0;
					base.ctx(ctx);

					// we’re done with the rotating so restore the unrotated context
					ctx.restore();
				} else {
					base.ctx(ctx);
				}
			 */

			// base.ctx(ctx);
		}

		for (i in 0...this.arr.length) {
			var base = this.arr[i];
			if (base == null)
				continue;

			base.ctx(ctx);
		}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

	// ____________________________________ unique functions for this specific class ____________________________________

	public function hide() {
		// hide this group with
		// opacity:0 // old way... doesn't work that well for canvas
		fillOpacity = 0;
		strokeOpacity = 0;
	}

	public function test() {
		trace('test if casting works');
	}

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<IBase> {
		return arr;
	}

	function set_arr(value:Array<IBase>):Array<IBase> {
		return arr = value;
	}
}
