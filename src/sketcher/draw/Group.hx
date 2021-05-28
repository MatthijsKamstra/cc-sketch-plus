package sketcher.draw;

import sketcher.util.MathUtil;
import js.Browser.*;

class Group extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'group'; // base (get class name?)

	@:isVar public var arr(get, set):Array<IBase>;

	var isOpacityOverride:Bool = false;

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
		if (isOpacityOverride) {
			xml.set('opacity-override', 'true');
		}

		// Inkscape adjustments for easy import
		xml.set('inkscape:groupmode', 'layer');
		xml.set('inkscape:label', '${id} Layer');

		// if (isOpacityOverride) {
		// 	untyped base.strokeOpacity = 0;
		// 	untyped base.fillOpacity = 0;
		// }
		var comment = Xml.createComment('Group: ${id}');
		xml.addChild(comment); // not sure why?
		xml.addChild(Xml.parse('<desc>${id}</desc>'));
		for (i in 0...this.arr.length) {
			// untyped xml.appendChild(this.arr[i].svg);
			// xml.addChild(Xml.createComment(this.arr[i].type));
			var base = this.arr[i];
			// untyped base.fillOpacity = 0;
			xml.addChild(Xml.parse(base.svg(null)));
		}
		// xml.set('x', '0');
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.groupCollapsed('Group (${id}) info canvas');
			console.info('the following work\n- strokeOpacity\n- fillOpacity\n- fillColor\n- strokeColor\n- strokeWeight\n- rotate');
			console.warn('doesn\'t work\n- move');
			console.groupEnd();
			Group.ISWARN = true;
		}

		// set transforms on group also on individuals
		// run loop and update elements with group info
		for (i in 0...this.arr.length) {
			var base = this.arr[i];
			if (base == null)
				continue;

			// override the original values if the are not set
			if (this.fillOpacity != null && cast(base, Base).fillOpacity == null) {
				cast(base, Base).fillOpacity = this.fillOpacity;
			}
			if (this.strokeOpacity != null && cast(base, Base).strokeOpacity == null) {
				cast(base, Base).strokeOpacity = this.strokeOpacity;
			}
			if (this.fillColor != null && cast(base, Base).fillColor == null) {
				cast(base, Base).fillColor = this.fillColor;
			}
			if (this.strokeColor != null && cast(base, Base).strokeColor == null) {
				cast(base, Base).strokeColor = this.strokeColor;
			}
			if (this.strokeWeight != null) {
				cast(base, Base).strokeWeight = this.strokeWeight;
			}
			if (isOpacityOverride) {
				// used for g.hide();
				cast(base, Base).strokeOpacity = this.strokeOpacity;
				cast(base, Base).fillOpacity = this.fillOpacity;
			}
		}

		// create canvas to create shapes into
		var newCanvas = document.createCanvasElement();
		newCanvas.width = ctx.canvas.width;
		newCanvas.height = ctx.canvas.height;
		var newCtx = newCanvas.getContext2d();

		// run loop again but now with updated info
		// write in new canvas
		for (i in 0...this.arr.length) {
			var base = this.arr[i];
			if (base == null)
				continue;
			// console.info(this.id + " --> " + base.type);
			base.ctx(newCtx);
			// base.ctx(ctx);
		}
		// check if we need to rotate
		// FIXME: move?
		if (this.rotate != null) {
			// the alternative is to untranslate & unrotate after drawing
			ctx.save();
			// move to the center of the canvas
			ctx.translate(this.rx, this.ry);
			// rotate the canvas to the specified degrees
			ctx.rotate(MathUtil.radians(this.rotate));
			// draw the image
			// since the context is rotated, the image will be rotated also
			ctx.drawImage(newCanvas, -this.rx, -this.ry);
			// we’re done with the rotating so restore the unrotated context
			ctx.restore();
		} else {
			ctx.drawImage(newCanvas, 0, 0);
		}
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

	// ____________________________________ unique functions for this specific class ____________________________________

	public function hide() {
		// hide this group with
		// opacity:0 // old way... doesn't work that well for canvas
		fillOpacity = 0;
		strokeOpacity = 0;
		isOpacityOverride = true;
	}

	public function test() {
		trace('test if casting works');
	}

	public function getHeight() {
		// trace(arr.length);
		for (i in 0...this.arr.length) {
			var group = this.arr[i];
			// trace(group.id);
			// trace(cast(group, Group).arr.length);

			for (j in 0...cast(group, Group).arr.length) {
				var sh = cast(group, Group).arr[j];
				// trace(sh);
				if (sh.type == 'rectangle') {
					// trace(cast(sh, Rectangle));
				}
			}
		}

		return 'WIP group.getHeight()';
	}

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<IBase> {
		return arr;
	}

	function set_arr(value:Array<IBase>):Array<IBase> {
		return arr = value;
	}
}
