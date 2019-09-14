package draw;

class Group extends Base implements IBase {
	public var type = 'Group'; // base (get class name?)

	@:isVar public var scale(get, set):Float;
	@:isVar public var rotation(get, set):Float;

	@:isVar public var arr(get, set):Array<IBase>;

	/**
	 *
	 */
	public function new(arr:Array<IBase>) {
		this.arr = arr;
		super('g');
	}

	public function svg(settings:Settings):String {
		if (this.getTransform() != '') {
			xml.set('transform', this.getTransform());
		}
		var comment = Xml.createComment('Group: ${id}');
		xml.addChild(comment); // not sure why?
		xml.addChild(Xml.parse('<desc>${id}</desc>'));
		for (i in 0...this.arr.length) {
			// untyped xml.appendChild(this.arr[i].svg);
			// xml.addChild(Xml.createComment(this.arr[i].type));
			var temp = this.arr[i];
			xml.addChild(Xml.parse(temp.svg(null)));
		}
		// xml.set('x', '0');
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
	}

	// ____________________________________ unique functions for this specific class ____________________________________

	public function test() {
		trace('test if casting works');
	}

	// ____________________________________ getter/setter ____________________________________

	function get_scale():Float {
		return scale;
	}

	function set_scale(value:Float):Float {
		return scale = value;
	}

	function get_rotation():Float {
		return rotation;
	}

	function set_rotation(value:Float):Float {
		return rotation = value;
	}

	function get_arr():Array<IBase> {
		return arr;
	}

	function set_arr(value:Array<IBase>):Array<IBase> {
		return arr = value;
	}
}
