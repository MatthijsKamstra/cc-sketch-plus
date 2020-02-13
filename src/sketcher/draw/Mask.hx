package sketcher.draw;

class Mask extends Base implements IBase {
	public var type = 'Mask'; // base (get class name?)

	var img = 'https://placeimg.com/200/200/tech';

	public function new() {
		super('mask');
	}

	public function svg(?settings:Settings):String {
		// todo look at gradient for the correct solution
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {}

	public function gl(gl:js.html.webgl.RenderingContext) {}
}
