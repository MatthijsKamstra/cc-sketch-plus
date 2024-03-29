package sketcher.util;

import sketcher.AST;

/**
 * Math related stuff is found here
 * 		- radians & convertions
 * 		- degree & convertions
 * 		- etc
 *
 * @example
 * ```
 * import sketcher.util.MathUtil;
 * MathUtil.random (10);
 *
 * // or
 *
 * import sketcher.util.MathUtil.*;
 * random(10); // make it easier to read
 * ```
 *
 */
class MathUtil {
	/**
	 * convert degree to radians
	 *
	 * @param deg
	 * @return Float
	 */
	static public function radians(deg:Float):Float {
		return deg * Math.PI / 180;
	};

	/**
	 * convert radians to degree
	 *
	 * @param rad
	 * @return Float
	 */
	static public function degrees(rad:Float):Float {
		return rad * 180 / Math.PI;
	};

	// public function rotateDegrees(deg) {
	// 	this.rotate(radians(deg));
	// }
	// public function rotateDeg(deg) {
	// 	this.rotate(radians(deg));
	// }
	static public function degreesToPoint(deg, diameter) {
		var rad = Math.PI * deg / 180;
		var r = diameter / 2;
		return {x: r * Math.cos(rad), y: r * Math.sin(rad)};
	}

	static public function distributeAngles(me, total) {
		return me / total * 360;
	}

	/**
	 * change nr to value above zero (-1 becomes 1)
	 *
	 * @param nr
	 * @return Float
	 */
	static public function isPositive(nr:Float):Float {
		if (nr < 0) {
			nr *= -1;
		}
		return nr;
	}

	/**
	 * calculate distance between two point (x,y)
	 * easier to remember
	 *
	 * @param x1	point 1, xpos
	 * @param y1	point 1, ypos
	 * @param x2	point 2, xpos
	 * @param y2	point 2, ypos
	 *
	 * @return  	distance between two points
	 */
	static public function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
		return dist(x1, y1, x2, y2);
	}

	static public function distancePoint(p0:Point, p1:Point):Float {
		return dist(p0.x, p0.y, p1.x, p1.y);
	}

	/**
	 * calculate distance between two point (x,y)
	 * easier to remember
	 *
	 * @param x1	point 1, xpos
	 * @param y1	point 1, ypos
	 * @param x2	point 2, xpos
	 * @param y2	point 2, ypos
	 *
	 * @return  	distance between two points
	 */
	static public function dist(x1:Float, y1:Float, x2:Float, y2:Float) {
		x2 -= x1;
		y2 -= y1;
		return Math.sqrt((x2 * x2) + (y2 * y2));
	}

	/**
	 * [pythagoreanTheorem description]
	 *
	 * @example
	 * 			trace (MathUtil.pythagoreanTheorem(0, 5, 10)); // 8.66025403784439
	 *			trace (MathUtil.pythagoreanTheorem(8.66025403784439, 5, 0)); // 10
	 *			trace (MathUtil.pythagoreanTheorem(8.66025403784439, 0, 10)); // 5
	 *
	 * @param  a 	side A
	 * @param  b 	side B
	 * @param  c 	hypotenuse C
	 */
	public static function pythagoreanTheorem(a:Float = null, b:Float = null, c:Float = null):Float {
		if (a == null && b == null && c == null) {
			trace("Really? Perhaps you should use some data");
			return 0;
		}
		var value = 0.0;

		if (c == null || c == 0)
			value = Math.sqrt(a * a + b * b);
		if (a == null || a == 0)
			value = Math.sqrt(c * c - b * b);
		if (b == null || b == 0)
			value = Math.sqrt(c * c - a * a);

		return value;
	}

	/**
	 * calculate the circumference of a circle (omtrek)
	 * 	Omtrek = pi * diameter = 2 * pi * straal
	 *
	 * 	@example
	 * 		MathUtil.circumferenceCircle(10); // 62.83185307179586
	 *
	 * @param radius 			radius of circel
	 * @return Float			circumference
	 */
	static public function circumferenceCircle(radius:Float):Float {
		return Math.PI * radius * 2;
	}

	/**
	 * calculate the circumference of a circle (omtrek)
	 * 	Omtrek = pi * diameter = 2 * pi * straal
	 *
	 * 	@example
	 * 		MathUtil.circumference2RadiusCircle(62.83185307179586); // 10
	 *
	 * @param circumference 	circumference of cicle
	 * @return Float			radius circle
	 */
	static public function circumference2RadiusCircle(circumference:Float):Float {
		return circumference / (Math.PI * 2);
	}

	/**
	 * Oppervlakte = 1/4 * pi * diameter2 = pi * straal2
	 *
	 * 	@example
	 * 		MathUtil.areaCircle(10); // 62.83185307179586
	 *
	 * @param radius
	 * @return Float
	 */
	static public function areaCircle(radius:Float):Float {
		return Math.PI * Math.sqrt(radius);
	}

	/**
	 * Get a random number between `min` and `max`
	 *
	 * @example		cc.util.MathUtil.randomInteger(10,100); // producess an number between 10 and 100
	 *
	 * @param min 	minimum value
	 * @param max 	maximum value (optional: if not `max == min` and `min == 0` )
	 * @return Int	number between `min` and `max`
	 */
	static public function randomInteger(min:Int, ?max:Int):Int {
		if (max == null) {
			max = min;
			min = 0;
		}
		return Math.floor(Math.random() * (max + 1 - min)) + min;
	}

	static public function randomInt(min, ?max):Int {
		return randomInteger(min, max);
	}

	/**
	 * Get a random number between `min` and `max`
	 *
	 * @example		cc.util.MathUtil.random(10,100); // producess an number between 10 and 100
	 *
	 * @param min 	minimum value
	 * @param max 	maximum value
	 * @return Float	number between `min` and `max`
	 */
	static public function random(?min:Float, ?max:Float):Float {
		if (min == null) {
			min = 0;
			max = 1;
		} else if (max == null) {
			max = min;
			min = 0;
		}
		return (Math.random() * (max - min)) + min;
	};

	static public function randomP(?min:Float, ?max:Float) {
		if (min == null) {
			min = 0.1;
			max = 1;
		} else if (max == null) {
			max = min;
			min = 0.1;
		}
		return (Math.random() * (max - min)) + min;
	};

	/**
	 * Calculate a chance of 80 procent for being true
	 *
	 * @example 	MathUtil.chance(80); // 80% chance for true
	 *
	 * what I want is chance(80) or chance(0.8)
	 * and get a 80% change for a true, otherwise false
	 * chance
	 * @param value a value between 0 and 1 of 0 and 99
	 */
	static public function chance(value:Float):Bool {
		if (value > 1)
			value /= 100;
		// return (random(value) > value - 1);
		return Math.random() < value;
	}

	static public function chanceTrue(value:Float):Bool {
		if (value > 1)
			value /= 100;
		return Math.random() < value;
	}

	static public function chanceFalse(value:Float):Bool {
		if (value > 1)
			value /= 100;
		return Math.random() > value;
	}

	/**
	 * get value 1 or -1
	 * sort of like the yes/no version (`MathUtil.flip()`)
	 * usefull for direction change
	 */
	static public function posNeg() {
		return randomInt(0, 1) * 2 - 1;
	}

	/**
	 * its either yes or no (true or false)
	 *
	 * @example 		trace(MathUtil.flip());
	 * @return Bool
	 */
	static public function flip():Bool {
		return Math.random() < 0.5;
	}

	/**
	 * calculate the angle between two point
	 * @param cx		center point x
	 * @param cy		center point y
	 * @param ex		end point x
	 * @param ey		end point y
	 * @return Float
	 */
	static public function angle(cx:Float, cy:Float, ex:Float, ey:Float):Float {
		var dy = ey - cy;
		var dx = ex - cx;
		var theta = Math.atan2(dy, dx); // range (-PI, PI]
		theta *= 180 / Math.PI; // rads to degs, range (-180, 180]
		if (theta < 0)
			theta = 360 + theta; // range [0, 360);
		if (theta == 360)
			theta = 0;
		return theta;
	}

	static public function map(value, min1, max1, min2, max2, clampResult) {
		var returnvalue = ((value - min1) / (max1 - min1) * (max2 - min2)) + min2;
		if (clampResult)
			return clamp(returnvalue, min2, max2);
		else
			return returnvalue;
	};

	/**
	 * get an orbit value: use a centerpoint and radius to create points around this centerpoint
	 *
	 *	@example
	 *		import cc.util.MathUtil;
	 *		var point = MathUtil.orbit (100,100,20, 360/4);
	 *		trace('${point.x} , ${point.y}');
	 *
	 *
	 * @param xpos center point x
	 * @param ypos center point y
	 * @param angle in degree (360)
	 * @param radius the radius of circle
	 * @return AST.Point
	 */
	static public function orbit(xpos:Float, ypos:Float, angle:Float, radius:Float):AST.Point {
		// plot the balls x to cos and y to sin
		var _xpos = xpos + Math.cos(radians(angle)) * radius;
		var _ypos = ypos + Math.sin(radians(angle)) * radius;
		return {x: _xpos, y: _ypos};
	}

	static public function orbitX(origin:Float, angle:Float, radius:Float):Float {
		return origin + Math.cos(radians(angle)) * radius;
	}

	static public function orbitY(origin:Float, angle:Float, radius:Float):Float {
		return origin + Math.sin(radians(angle)) * radius;
	}

	static public function orbitZ(origin:Float, angle:Float, radius:Float):Float {
		return origin + Math.cos(radians(angle)) * radius;
	}

	/**
	 * Randomly shuffle an array
	 * https://stackoverflow.com/a/2450976/1293256
	 * @param  {Array} array The array to shuffle
	 * @return {String}      The first item in the shuffled array
	 */
	static public function shuffle(array:Array<Dynamic>):Array<Dynamic> {
		var currentIndex = array.length;
		var temporaryValue, randomIndex;

		// While there remain elements to shuffle...
		while (0 != currentIndex) {
			// Pick a remaining element...
			randomIndex = Math.floor(Math.random() * currentIndex);
			currentIndex -= 1;

			// And swap it with the current element.
			temporaryValue = array[currentIndex];
			array[currentIndex] = array[randomIndex];
			array[randomIndex] = temporaryValue;
		}

		return array;
	};

	/**
	 * sent a value, and check if it is in the correct range
	 *
	 * @example
	 * 	 MathUtil.clamp(Math.round(r), 0, 255) // a value r should be between 0 and 255
	 *
	 * @param value		value to check
	 * @param min		minimum value
	 * @param max		maximum value
	 */
	static public function clamp(value, min, max) {
		return Math.min(Math.max(value, Math.min(min, max)), Math.max(min, max));
	}

	/**
	 * @example
	 * 	 MathUtil.formatByteSizeString(12586); //
	 * @param bytes
	 */
	static public function formatByteSizeString(bytes:Int):String {
		if (bytes < 1024)
			return bytes + " bytes";
		else if (bytes < 1048576)
			return toFixed((bytes / 1024), 3) + " KiB";
		else if (bytes < 1073741824)
			return toFixed((bytes / 1048576), 3) + " MiB";
		else
			return toFixed((bytes / 1073741824), 3) + " GiB";
	};

	/**
	 * return formatByteSize(sizeOf(obj));
	 *
	 * trace(MathUtil.formatByteSize(req.responseBytes.length));
	 * trace(MathUtil.formatByteSizeString(req.responseBytes.length));
	 *
	**/
	static public function formatByteSize(bytes:Int):Float {
		if (bytes < 1024)
			return bytes;
		else if (bytes < 1048576)
			return toFixed((bytes / 1024), 3);
		else if (bytes < 1073741824)
			return toFixed((bytes / 1048576), 3);
		else
			return toFixed((bytes / 1073741824), 3);
	};

	/**
	 * Uses Math.round to fix a floating point number to a set precision.
	 * Taken from Franco Ponticelli's THX library: https://github.com/fponticelli/thx/blob/master/src/Floats.hx#L206
	 *
	 * @param number
	 * @param precision = 2
	 * @return Float
	 */
	public static function toFixed(number:Float, ?precision = 2):Float {
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}

	/**
	 * use the cos to calculate the angle or one of the sides ('aanliggende zijde' or 'schuine zijde')
	 *
	 * @usage 	trace ('aanliggende zijde: ' + CASsostoa ( 45, Null, 20 );
	 * @param	angleInDegree		angle in degrees	(return value will be in degrees)
	 * @param	aSide				'aanliggende zijde'	whatever size (pixel or cm)
	 * @param	sSide				'schuine zijde' whatever size (pixel or cm)
	 * @return		depends on the data not send in the params
	 * 				angle in degrees or a side value (depends on input: pixel or cm)
	 */
	public static function CASsostoa(angleInDegree:Float = null, aSide:Float = null, sSide:Float = null):Float {
		if ((angleInDegree) == null) {
			// return (caculate) the angle in degrees
			return toDegree(Math.acos(aSide / sSide));
		}
		if ((aSide) == null) {
			// return (caculate) the 'aanliggende zijde'
			return (Math.cos(toRadian(angleInDegree)) * sSide);
		}
		if ((sSide) == null) {
			// return (caculate) the 'schuine zijde'
			return (aSide / Math.cos(toRadian(angleInDegree)));
		}
		return null;
	}

	public static function cas(angleInDegree:Float = null, aSide:Float = null, sSide:Float = null):Float {
		return CASsostoa(angleInDegree, aSide, sSide);
	}

	/**
	 * use the sinus to calculate the angle or one of the sides ('overstaande zijde' or 'schuine zijde')
	 *
	 * @usage 	trace ('angle in degree: ' + casSOStoa ( null, 10, 20 );
	 * @param	angleInDegree		angle in degrees	(return value will be in degrees)
	 * @param	oSide				'overstaande zijde'	whatever size (pixel or cm)
	 * @param	sSide				'schuine zijde' whatever size (pixel or cm)
	 * @return		depends on the data not send in the params
	 * 				angle in degrees or a side value (depends on input: pixel or cm)
	 */
	public static function casSOStoa(angleInDegree:Float = null, oSide:Float = null, sSide:Float = null):Float {
		if ((angleInDegree) == null) {
			// return (caculate) the angle in degrees
			return toDegree(Math.asin(oSide / sSide));
		}
		if ((oSide) == null) {
			// return (caculate) the 'overliggende zijde'
			return (Math.sin(toRadian(angleInDegree)) * sSide);
		}
		if ((sSide) == null) {
			// return (caculate) the 'schuine zijde'
			return (oSide / Math.sin(toRadian(angleInDegree)));
		}
		return null;
	}

	public static function sos(angleInDegree:Float = null, oSide:Float = null, sSide:Float = null):Float {
		return casSOStoa(angleInDegree, oSide, sSide);
	}

	/**
	 * use the tan to calculate the angle or one of the sides ('overstaande zijde' or 'aanliggende zijde')
	 *
	 * @usage 	trace ('aanliggende zijde: ' + cassosTOA ( 80, 10, null );
	 * 			trace( ">> cassosTOA (null , 40 , 40) : " + cassosTOA (null , 40 , 40) );
	 * @param	angleInDegree		angle in degrees	(return value will be in degrees)
	 * @param	oSide				'overstaande zijde'	whatever size (pixel or cm)
	 * @param	aSide				'aanliggende zijde' whatever size (pixel or cm)
	 * @return		depends on the data not send in the params
	 * 				angle in degrees or a side value (depends on input: pixel or cm)
	 */
	public static function cassosTOA(angleInDegree:Float = null, oSide:Float = null, aSide:Float = null):Float {
		if ((angleInDegree) == null) {
			// return (caculate) the angle in degrees
			return toDegree(Math.atan(oSide / aSide));
		}
		if ((oSide) == null) {
			// return (caculate) the 'overliggende zijde'
			return (Math.tan(toRadian(angleInDegree)) * aSide);
		}
		if ((aSide) == null) {
			// return (caculate) the 'aanliggende  zijde'
			return (oSide / Math.tan(toRadian(angleInDegree)));
		}
		return null;
	}

	public static function toa(angleInDegree:Float = null, oSide:Float = null, aSide:Float = null):Float {
		return cassosTOA(angleInDegree, oSide, aSide);
	}

	// so we don't need other classes to make it work

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

	/**
	 * convert mm 2 pixels
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

	public static function px2mm(value:Float):Float {
		return pixel2mm(value);
	}

	/**
	 * Converts an angle from radians to degrees
	 * @param	angleRadian	A number representing the angle in radians
	 * @return					The angle in degrees
	 */
	public static function toDegree(angleRadian:Float):Float {
		var degrees:Float = angleRadian / (Math.PI / 180);
		// degrees = radians * 180/Math.PI
		return (degrees);
	}

	/**
	 * Converts an angle from degrees to radians.
	 * @param	angleInDegree	A number representing the angle in dregrees
	 * @return					The angle in radians
	 */
	public static function toRadian(angleInDegree:Float):Float {
		var radians:Float = angleInDegree * Math.PI / 180;
		// radians = degrees * Math.PI/180
		return (radians);
	}

	/**
		function xyz(px, py, pz, pitch, roll, yaw) {

		var cosa = Math.cos(yaw);
		var sina = Math.sin(yaw);

		var cosb = Math.cos(pitch);
		var sinb = Math.sin(pitch);

		var cosc = Math.cos(roll);
		var sinc = Math.sin(roll);

		var Axx = cosa*cosb;
		var Axy = cosa*sinb*sinc - sina*cosc;
		var Axz = cosa*sinb*cosc + sina*sinc;

		var Ayx = sina*cosb;
		var Ayy = sina*sinb*sinc + cosa*cosc;
		var Ayz = sina*sinb*cosc - cosa*sinc;

		var Azx = -sinb;
		var Azy = cosb*sinc;
		var Azz = cosb*cosc;

		x = Axx*px + Axy*py + Axz*pz;
		y = Ayx*px + Ayy*py + Ayz*pz;
		z = Azx*px + Azy*py + Azz*pz;

		return {x:x, y:y, z:z};
		}
	 */
}
