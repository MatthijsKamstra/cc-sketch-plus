package draw;

class Group extends draw.Base implements IBase {
	public var type = 'Group'; // base (get class name?)

	@:isVar public var arr(get, set):Array<IBase>;

	/**
	 *
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

	public function hide() {
		// hide this group with
		// opacity:0
		opacity = 0;
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
