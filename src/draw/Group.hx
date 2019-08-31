package draw;

class Group extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;

	@:isVar public var scale(get, set):Float;
	@:isVar public var rotation(get, set):Float;

	@:isVar public var arr(get, set):Array<IBase>;

	public var type = 'Group'; // base (get class name?)

	/**
	 *
	 */
	public function new(arr:Array<IBase>) {
		// this.x = x;
		// this.y = y;
		this.arr = arr;
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('g');
		if (this.id != null)
			xml.set('id', Std.string(this.id));
		xml.set('fill', 'green');
		var comment = Xml.createComment('test');
		xml.addChild(comment);
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
		trace('test');
	}

	// ____________________________________ getter/setter ____________________________________

	function get_y():Int {
		return y;
	}

	function set_y(value:Int):Int {
		return y = value;
	}

	function get_x():Int {
		return x;
	}

	function set_x(value:Int):Int {
		return x = value;
	}

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
