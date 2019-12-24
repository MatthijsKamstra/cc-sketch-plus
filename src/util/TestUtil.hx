package util;

import cc.util.ColorUtil.*;
import cc.util.GridUtil;
import cc.AST;

class TestUtil {
	public function new() {}

	/**
	 * use with de data of GridUtil
	 * create dot point with a border of grid
	 * @example
	 * 			var grid = ...
	 * 			if (isDebug) {
	 *				util.TestUtil.gridDots(sketch, grid);
	 * 			}
	 */
	static public function gridDots(sketch:Sketcher, grid:GridUtil) {
		var _circlesArray:Array<draw.IBase> = [];
		for (i in 0...grid.array.length) {
			var point:Point = grid.array[i];
			var circle = sketch.makeCircle(point.x, point.y, 1);
			circle.fillColor = getColourObj(PINK, 1);

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
