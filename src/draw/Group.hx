package draw;

class Group extends Base implements IBase {
	@:isVar public var y(get, set):Int;
	@:isVar public var x(get, set):Int;

	@:isVar public var scale(get, set):Float;
	@:isVar public var rotation(get, set):Float;

	@:isVar public var arr(get, set):Array<IBase>;

	public var type = 'Group'; // base (get class name?)

	/**
	 * WIP
	 * @param obj1
	 * @param obj2
	 */
	public function new(obj1:IBase, obj2:IBase) {
		// this.x = x;
		// this.y = y;
		this.arr = [obj1, obj2];
	}

	public function svg(settings:Settings):String {
		var xml = Xml.createElement('g');
		var comment = Xml.createComment('test');
		xml.addChild(comment);
		for (i in 0...this.arr.length) {
			xml.addChild(Xml.createComment(this.arr[i].type));
		}
		// xml.set('x', '0');
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		ctx.beginPath();
		ctx.fill();
		ctx.stroke();
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
