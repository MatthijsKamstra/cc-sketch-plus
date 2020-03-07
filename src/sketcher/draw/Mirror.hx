package sketcher.draw;

import js.Browser.*;

class Mirror extends Base implements IBase {
	public static var ISWARN:Bool;

	public var type = 'mirror'; // base (get class name?)

	public var baseArray:Array<IBase> = []; // make sure svg has a copy of all the items on screen

	var dir:Mirror.MirrorType;

	public function new(?dir:Mirror.MirrorType) {
		if (dir == null)
			dir = MirrorType.Right;
		this.dir = dir;

		super('mirror');
	}

	public function svg(?settings:Settings):String {
		if (!ISWARN) {
			console.warn('Mirror doens\'t work the same as canvas, use with care');
			ISWARN = true;
		}

		for (i in 0...baseArray.length) {
			var _baseArray = baseArray[i];
			// trace(_baseArray);
		}

		// todo look at gradient for the correct solution
		return xml.toString();
	}

	public function ctx(ctx:js.html.CanvasRenderingContext2D) {
		if (!ISWARN) {
			console.warn('Mirror works only for the right part of the sketch');
			ISWARN = true;
		}

		var _y = 0;
		var _y2 = Sketcher.Globals.h / 2;
		var _x = 0;
		var _x2 = Sketcher.Globals.w / 2;
		var _w = Sketcher.Globals.w / 2;
		var _h = Sketcher.Globals.h / 2;

		// draw the original image
		// this is already done
		// ctx.drawImage(img, x, y, thumbWidth, thumbWidth);
		ctx.save();

		// translate to a point from where we want to redraw the new image
		ctx.translate(_x2, _y);

		ctx.scale(-1, 1);
		// ctx.globalAlpha = 0.25;

		// clear rectangle in which we want to copy, so if no background color is used we don't have images there
		ctx.clearRect(0, 0, Sketcher.Globals.w, Sketcher.Globals.h);

		// redraw only bottom part of the image
		ctx.drawImage(ctx.canvas, _x2, _y, Sketcher.Globals.w, Sketcher.Globals.h, 0, 0, Sketcher.Globals.w, Sketcher.Globals.h);
		// destination x, y is set to 0, 0 (which will be at translated xy)

		// Revert transform and scale
		ctx.restore();
	}

	public function gl(gl:js.html.webgl.RenderingContext) {}
}

enum abstract MirrorType(String) from String to String {
	var Left = 'left';
	var Right = 'right'; // currently default
	var Top = 'top';
	var Bottom = 'bottom';
}
