interface IBase {
	public var type:String;
	public function svg(settings:Settings):String;
	public function ctx(ctx:js.html.CanvasRenderingContext2D):Void;
	public function toString():String;
}
