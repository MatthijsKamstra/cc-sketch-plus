package sketcher.draw;

#if js
import js.Browser.*;
import js.html.webgl.RenderingContext;
#end
import sketcher.AST.Point;
import sketcher.util.ColorUtil;
import sketcher.util.MathUtil;

class Background extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'background'; // base (get class name?)

	public function new(color:String) {
		super('rect');
		this.fillColor = color;
		this.id = 'background-layer';
	}

	public function svg(?settings:Settings):String {
		xml.set('x', '0');
		xml.set('y', "0");

		xml.set('width', Std.string(Globals.Globals.w));
		xml.set('height', Std.string(Globals.Globals.h));

		return xml.toString();
	}

	#if js
	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		// set everything to default values
		useDefaultsCanvas();

		var _fillColor = ColorUtil.assumption(this.fillColor);
		ctx.fillStyle = ColorUtil.getColourObj(_fillColor, this.fillOpacity);

		ctx.beginPath();
		ctx.rect(0, 0, Globals.Globals.w, Globals.Globals.h);
		ctx.fill();
		ctx.closePath();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {
		if (!ISWARN) {
			console.warn('webgl is not implemented yet');
			ISWARN = true;
		}

		var c = '#ff3333';

		var rgba = ColorUtil.assumption(c);
		// trace(rgba);
		// Set clear color to black, fully opaque
		// gl.clearColor(rgba.r, rgba.g, rgba.b, rgba.a);
		// Clear the color buffer with specified clear color
		// gl.clear(gl.COLOR_BUFFER_BIT);
		// gl.clear(0);

		gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);
		// Set the clear color to darkish green.
		gl.clearColor(rgba.r / 255, rgba.g / 255, rgba.b / 255, rgba.a);
		// gl.clearColor(0.0, 0.5, 0.0, 1.0);
		// Clear the context with the newly set color. This is
		// the function call that actually does the drawing.
		gl.clear(RenderingContext.COLOR_BUFFER_BIT);
	}
	#end
}
