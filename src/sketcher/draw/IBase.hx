package sketcher.draw;

interface IBase {
	public var type:String;
	@:isVar public var id(get, set):String;
	// TODO remove settings
	public function svg(?settings:Settings):String;
	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D):Void;
	public function gl(gl:js.html.webgl.RenderingContext):Void;
	#end
	public function toString():String;
	public function getName():String;
}
