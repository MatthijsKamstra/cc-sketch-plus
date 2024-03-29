package sketcher.model.constants;

import sketcher.AST;

/**
	A1	594 x 841 mm	23.4 x 33.1 in
	A2	420 x 594 mm	16.5 x 23.4 in
	A3	297 x 420 mm	11.7 x 16.5 in
	A4	210 x 297 mm	8.3 x 11.7 in
	A5	148 x 210 mm	5.8 x 8.3 in
	A6	105 x 148 mm	4.1 x 5.8 in
**/
class Paper {
	// http://www.papersizes.org/a-paper-sizes.htm
	public static inline var A6:String = 'a6';
	public static inline var A5:String = 'a5';
	public static inline var A4:String = 'a4';
	public static inline var A3:String = 'a3';
	public static inline var A2:String = 'a2';
	public static inline var A1:String = 'a1';
	public static var ARR:Array<String> = [A6, A5, A4, A3, A2, A1];

	/**
	 * inPixel
	 *
	 * @example
	 * ```
	 * 		sketcher.model.constants.Paper.inPixel(Paper.PaperSize.A4);
	 * ```
	 * @see
	 *
	 * @param
	 *
	 * @return
	 */
	public static function inPixel(papersize:PaperSize):Rectangle {
		var rectangle:Rectangle = {
			width: 0,
			height: 0,
			x: 0,
			y: 0,
		};
		var w:Int;
		var h:Int;
		switch (papersize) {
			case PaperSize.A1:
				w = 594;
				h = 841; // mm	23.4 x 33.1 in
			case PaperSize.A2:
				w = 420;
				h = 594; // mm	16.5 x 23.4 in
			case PaperSize.A3:
				w = 297;
				h = 420; // mm	11.7 x 16.5 in
			case PaperSize.A4:
				w = 210;
				h = 297; // mm	8.3 x 11.7 in
			case PaperSize.A5:
				w = 148;
				h = 210; // mm	5.8 x 8.3 in
			case PaperSize.A6:
				w = 105;
				h = 148; // mm	4.1 x 5.8 in
			default:
				trace("case '" + papersize + "': trace ('" + papersize + "');");
		}
		rectangle.width = mm2pxInt(w);
		rectangle.height = mm2pxInt(h);
		rectangle.x = 0;
		rectangle.y = 0;
		return rectangle;
	}

	public static function inMM(papersize:PaperSize):Rectangle {
		var w:Int = 0;
		var h:Int = 0;
		switch (papersize) {
			case PaperSize.A1:
				w = 594;
				h = 841; // mm	23.4 x 33.1 in
			case PaperSize.A2:
				w = 420;
				h = 594; // mm	16.5 x 23.4 in
			case PaperSize.A3:
				w = 297;
				h = 420; // mm	11.7 x 16.5 in
			case PaperSize.A4:
				w = 210;
				h = 297; // mm	8.3 x 11.7 in
			case PaperSize.A5:
				w = 148;
				h = 210; // mm	5.8 x 8.3 in
			case PaperSize.A6:
				w = 105;
				h = 148; // mm	4.1 x 5.8 in
			default:
				trace("case '" + papersize + "': trace ('" + papersize + "');");
		}
		var rectangle = {
			width: w,
			height: h,
			x: 0,
			y: 0,
		};
		return rectangle;
	}

	/**
	 * convert mm 2 pixels
	 *
	 * @param value
	 * @return Float
	 */
	public static function mm2pixel(value:Float):Float {
		// var dpi = 72;
		var dpi = 96;

		// mm = ( pixels * 25.4 ) / DPI
		// Width : 10 cm * 300 / 2.54 = 1181 pixels
		// Height: 15 cm * 300 / 2.54 = 1772 pixels

		return value * dpi / 25.4;
	}

	public static function mm2px(value:Float):Float {
		return mm2pixel(value);
	}

	public static function mm2pxInt(value:Float):Int {
		return Math.round(mm2pixel(value));
	}

	public static function mm2pxConvert(value:Float):Dynamic {
		var obj = {
			'mm': value,
			'converted': {
				'px': mm2px(value),
				'px int': mm2pxInt(value),
				'mm': px2mm(mm2px(value)),
				'mm int': px2mmInt(mm2px(value)),
			}
		};
		return obj;
	}

	/**
	 * https://www.pixelto.net/px-to-mm-converter
	 *
	 * dpi is the pixel density or dots per inch.
	 * 96 dpi means there are 96 pixels per inch.
	 * 1 inch is equal to 25.4 millimeters.
	 *
	 * 	1 inch = 25.4 mm
	 * 		dpi = 96 px / in
	 * 		96 px / 25.4 mm
	 *
	 * 		Therefore one pixel is equal to
	 * 		1 px = 25.4 mm / 96
	 * 		1 px = 0.26458333 mm
	 *
	 * @param value
	 * @return Float
	 */
	public static function pixel2mm(value:Float):Float {
		// mm = ( pixels * 25.4 ) / DPI
		// var dpi = 72;
		var dpi = 96;
		return value * 25.4 / dpi;
	}

	public static function px2mmInt(value:Float):Int {
		return Math.round(pixel2mm(value));
	}

	public static function px2mm(value:Float):Float {
		return pixel2mm(value);
	}

	/**
	 * [Description]
	 * @param mm
	 * @param dpi
	 * @return Float
	 */
	public static function convertmm2pixel(mm:Float, ?dpi:Int = 72):Float {
		// mm = ( pixels * 25.4 ) / DPI
		// Width : 10 cm * 300 / 2.54 = 1181 pixels
		// Height: 15 cm * 300 / 2.54 = 1772 pixels

		return (mm * dpi / 25.4);
	}
}

typedef Rectangle = {
	@:optional var _id:Int;
	@:optional var x:Int;
	@:optional var y:Int;
	var width:Int;
	var height:Int;
};

enum PaperSize {
	A6;
	A5;
	A4;
	A3;
	A2;
	A1;
}
