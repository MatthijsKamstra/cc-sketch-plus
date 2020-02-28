package sketcher.util;

/**
 * @source:
 *              https://medium.com/javascript-in-plain-english/find-difference-between-dates-in-javascript-80d9280d8598
 */
class TimeUtil {
	/**
	 * @example
	 *
	 * var d1 = Date.now();
	 * var d2 = new Date(2019,5,22).getTime(); //Jun 22 2019 in millisecond
	 *
	 * console.log(d1); //1573527098946
	 * console.log(d2); //1561141800000
	 */
	public function new() {
		// your code
	}

	/**
	 * 1 second = 1000 milliseconds
	 * @param d1
	 * @param d2
	 */
	public static function secondsDiff(d1:Float, d2:Float) {
		var millisecondDiff = d2 - d1;
		var secDiff = Math.floor((d2 - d1) / 1000);
		return secDiff;
	}

	/**
	 * 1 minutes = 60 seconds
	 * @param d1
	 * @param d2
	 */
	public static function minutesDiff(d1:Float, d2:Float) {
		var seconds = secondsDiff(d1, d2);
		var minutesDiff = Math.floor(seconds / 60);
		return minutesDiff;
	}

	/**
	 * 1 hour = 60 minutes
	 * @param d1
	 * @param d2
	 */
	public static function hoursDiff(d1:Float, d2:Float) {
		var minutes = minutesDiff(d1, d2);
		var hoursDiff = Math.floor(minutes / 60);
		return hoursDiff;
	}

	/**
	 * 1 day = 24 hours
	 * @param d1
	 * @param d2
	 */
	public static function daysDiff(d1:Float, d2:Float) {
		var hours = hoursDiff(d1, d2);
		var daysDiff = Math.floor(hours / 24);
		return daysDiff;
	}

	/**
	 * 1 week = 7 days
	 * @param d1
	 * @param d2
	 */
	public static function weeksDiff(d1:Float, d2:Float) {
		var days = daysDiff(d1, d2);
		var weeksDiff = Math.floor(days / 7);
		return weeksDiff;
	}

	/**
	 * [Description]
	 * @param d1
	 * @param d2
	 */
	public static function yearsDiff(d1:Float, d2:Float) {
		var date1 = Date.fromTime(d1);
		var date2 = Date.fromTime(d2);
		var yearsDiff = date2.getFullYear() - date1.getFullYear();
		return yearsDiff;
	}

	/**
	 * 1 month != 30 days Number of days in month is not same in all months , so we need to do it differently
	 * @param d1
	 * @param d2
	 */
	public static function monthsDiff(d1:Float, d2:Float) {
		var date1 = Date.fromTime(d1);
		var date2 = Date.fromTime(d2);
		var years = yearsDiff(d1, d2);
		var months = (years * 12) + (date2.getMonth() - date1.getMonth());
		return months;
	}
}
