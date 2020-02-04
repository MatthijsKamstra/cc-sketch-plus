package sketcher.debug;

import sketcher.util.ColorUtil.*;
import sketcher.util.GridUtil;
import sketcher.AST;
import sketcher.draw.IBase;

class Grid {
	public function new() {}

	/**
	 * use with de data of GridUtil
	 * create dot point with a border of grid
	 * @example
	 * 			var grid = ...
	 * 			if (isDebug) {
	 *				sketcher.debug.Grid.gridDots(sketch, grid);
	 * 			}
	 */
	static public function gridDots(sketch:Sketcher, grid:GridUtil) {
		var _circlesArray:Array<IBase> = [];
		for (i in 0...grid.array.length) {
			var point:Point = grid.array[i];
			var circle = sketch.makeCircle(point.x, point.y, 3);
			circle.fillColor = getColourObj(PINK, 1);
			circle.strokeOpacity = 0;
			_circlesArray.push(circle);
		}
		var rect = sketch.makeRectangle(grid.x, grid.y, grid.width, grid.height, false);
		rect.strokeWeight = 1;
		rect.strokeColor = getColourObj(GRAY, 0.5);
		rect.fillOpacity = 0;
		_circlesArray.push(rect);

		var circleGroup = sketch.makeGroup(_circlesArray);
		circleGroup.id = 'grid debug layer';
	}
}
