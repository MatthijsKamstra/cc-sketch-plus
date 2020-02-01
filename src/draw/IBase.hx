package draw;

interface IBase {
	public var type:String;
	@:isVar public var id(get, set):String;
	// TODO remove settings
	public function svg(?settings:Settings):String;
	public function ctx(ctx:js.html.CanvasRenderingContext2D):Void;
	public function toString():String;
	public function getName():String;
}
