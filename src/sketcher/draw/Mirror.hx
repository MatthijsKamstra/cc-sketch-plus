package sketcher.draw;

import js.Browser.*;

class Mirror extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'mirror'; // base (get class name?)

	public function new() {
		super('mirror');
	}

	public function svg(?settings:Settings):String {
		if (!ISWARN) {
			console.warn('Mirror doens\'t work the same as canvas, use with care');
			ISWARN = true;
		}
		// todo look at gradient for the correct solution
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.warn('Mirror is still WIP');
			ISWARN = true;
		}

		var y = 0;
		var x = Sketcher.Globals.w / 2;
		// var x = 0;

		// trace('mirror');

		// draw the original image
		// ctx.drawImage(img, x, y, thumbWidth, thumbWidth);
		ctx.save();
		// translate to a point from where we want to redraw the new image
		ctx.translate(x, y);

		ctx.scale(-1, 1);
		// ctx.globalAlpha = 0.25;

		// clear
		ctx.clearRect(0, 0, Sketcher.Globals.w, Sketcher.Globals.h);

		// redraw only bottom part of the image
		ctx.drawImage(ctx.canvas, x, y, Sketcher.Globals.w, Sketcher.Globals.h, 0, 0, Sketcher.Globals.w, Sketcher.Globals.h);
		// destination x, y is set to 0, 0 (which will be at translated xy)

		// Revert transform and scale
		ctx.restore();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
}
