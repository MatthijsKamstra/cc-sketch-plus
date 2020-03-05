package sketcher.draw;

import js.Browser.*;

class Mask extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'mask'; // base (get class name?)

	@:isVar public var arr(get, set):Array<IBase>;

	// https://developer.mozilla.org/en-US/docs/Web/SVG/Element/mask

	/**
	 * create a group to join a couple of IBase items
	 * useful in `svg`, not so much in `canvas`
	 * might be usefull to push all actions into one transform
	 */
	public function new(arr:Array<IBase>) {
		this.arr = arr;
		super('mask');
	}

	public function svg(?settings:Settings):String {
		xml.set('x', '0');
		xml.set('y', "0");
		xml.set('width', Std.string(Sketcher.Globals.w));
		xml.set('height', Std.string(Sketcher.Globals.h));

		var comment = Xml.createComment('Mask: ${id}');
		xml.addChild(comment); // not sure why?
		// xml.addChild(Xml.parse('<desc>${id}</desc>'));
		for (i in 0...this.arr.length) {
			// untyped xml.appendChild(this.arr[i].svg);
			// xml.addChild(Xml.createComment(this.arr[i].type));
			var base = this.arr[i];
			cast(base, Base).noStroke().setFill('#FFFFFF');
			// untyped base.fillOpacity = 0;
			xml.addChild(Xml.parse(base.svg(null)));
		}

		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.warn('Mask doens\'t work the same as svg, use with care');
			ISWARN = true;
		}
		// Save the state, so we can undo the clipping
		ctx.save();

		// write in new canvas
		for (i in 0...this.arr.length) {
			var base = this.arr[i];
			if (base == null)
				continue;
			console.info(this.id + " --> " + base.type);
			// base.ctx(newCtx);
			base.ctx(ctx);
		}
		// Clip to the current path
		ctx.clip();

		// FIXME: masked / clipped canvas needs to go here

		// Undo the clipping
		ctx.restore();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<IBase> {
		return arr;
	}

	function set_arr(value:Array<IBase>):Array<IBase> {
		return arr = value;
	}
}
