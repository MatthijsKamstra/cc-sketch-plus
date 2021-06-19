package sketcher.draw;

#if js
import js.Browser.*;
#end

class Marker extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'marker'; // base (get class name?)

	@:isVar public var arr(get, set):Array<IBase>;

	@:isVar public var width(get, set):Float = 10;
	@:isVar public var height(get, set):Float = 10;

	@:isVar public var refX(get, set):Float = 0;
	@:isVar public var refY(get, set):Float = 0;

	public function new(arr:Array<IBase>) {
		this.arr = arr;
		super('marker');
	}

	public function svg(?settings:Settings):String {
		// xml.set('x', '0');
		// xml.set('y', "0");
		// xml.set('width', Std.string(Globals.Globals.w));
		// xml.set('height', Std.string(Globals.Globals.h));

		xml.set('markerWidth', '${this.width}');
		xml.set('markerHeight', '${this.height}');
		xml.set('refX', '${this.refX}');
		xml.set('refY', '${this.refY}');
		xml.set('orient', "auto");

		var comment = Xml.createComment('Marker: ${id}');
		xml.addChild(comment); // not sure why?
		// xml.addChild(Xml.parse('<desc>${id}</desc>'));
		for (i in 0...this.arr.length) {
			// untyped xml.appendChild(this.arr[i].svg);
			// xml.addChild(Xml.createComment(this.arr[i].type));
			var base = this.arr[i];
			// cast(base, Base).noStroke().setFill('#FFFFFF');
			// untyped base.fillOpacity = 0;
			xml.addChild(Xml.parse(base.svg(null)));
		}

		return xml.toString();
	}

	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.warn('Marker doens\'t work for canvas');
			ISWARN = true;
		}
		// Save the state, so we can undo the clipping
		// ctx.save();

		// // write in new canvas
		// for (i in 0...this.arr.length) {
		// 	var base = this.arr[i];
		// 	if (base == null)
		// 		continue;
		// 	console.info(this.id + " --> " + base.type);
		// 	// base.ctx(newCtx);
		// 	base.ctx(ctx);
		// }
		// // Clip to the current path
		// ctx.clip();

		// // FIXME: masked / clipped canvas needs to go here

		// // Undo the clipping
		// ctx.restore();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
	#end

	// ____________________________________ getter/setter ____________________________________

	function get_arr():Array<IBase> {
		return arr;
	}

	function set_arr(value:Array<IBase>):Array<IBase> {
		return arr = value;
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

	function get_refX():Float {
		return refX;
	}

	function set_refX(value:Float):Float {
		return refX = value;
	}

	function get_refY():Float {
		return refY;
	}

	function set_refY(value:Float):Float {
		return refY = value;
	}
}
