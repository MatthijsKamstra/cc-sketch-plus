package sketcher.util;

class WordsUtil {
	public function new() {
		// your code
	}

	/**
	 * @example
	 *
	 * ```
	 * for (i in 0...99) {
	 *		var wordPercentage = WordsUtil.number2Words(Math.round(i));
	 *		trace('$i - $wordPercentage');
	 * }
	 * trace(WordsUtil.number2Words(Math.round(pct * 100))); // Fifty-Eight
	 * ```
	 *
	 * @param value		Int between 0 and 99
	 * @return String
	 */
	public static function number2Words(value:Int):String {
		var arr = Std.string(value).split('');
		if (arr.length > 2) {
			trace('not possible (yet) for bigger the 99');
			return '';
		}
		var words = '';
		// 58

		// trace(arr);

		if (value < 20) {
			switch (value) {
				case 0:
					words += 'Zero'; //	(4)
				case 1:
					words += 'One'; //	(3)
				case 2:
					words += 'Two'; //	(3)
				case 3:
					words += 'Three'; //	(5)
				case 4:
					words += 'Four'; //	(4)
				case 5:
					words += 'Five'; //	(4)
				case 6:
					words += 'Six'; //	(3)
				case 7:
					words += 'Seven'; //	(5)
				case 8:
					words += 'Eight'; //	(5)
				case 9:
					words += 'Nine'; //	(4)
				case 10:
					words += 'Ten'; //	(3)
				case 11:
					words += 'Eleven'; //	(6)
				case 12:
					words += 'Twelve'; //	(6)
				case 13:
					words += 'Thirteen'; //	(8)
				case 14:
					words += 'Fourteen'; //	(8)
				case 15:
					words += 'Fifteen'; //	(7)
				case 16:
					words += 'Sixteen'; //	(7)
				case 17:
					words += 'Seventeen'; //	(9)
				case 18:
					words += 'Eighteen'; //	(8)
				case 19:
					words += 'Nineteen'; //	(8)
			}
		} else {
			switch (Std.parseInt(arr[0])) {
				case 1:
					trace('???');
				case 2:
					words += ('Twenty');
				case 3:
					words += ('Thirty');
				case 4:
					words += ('Fourty');
				case 5:
					words += ('Fifty');
				case 6:
					words += ('Sixty');
				case 7:
					words += ('Seventy');
				case 8:
					words += ('Eighty');
				case 9:
					words += ('Ninety');
				default:
					trace("case '" + arr[0] + "': trace ('" + arr[0] + "');");
			}

			words += ('-');

			switch (Std.parseInt(arr[1])) {
				case 0:
					words += '*';
				case 1:
					words += 'One';
				case 2:
					words += ('Two');
				case 3:
					words += ('Three');
				case 4:
					words += ('Four');
				case 5:
					words += ('Five');
				case 6:
					words += ('Six');
				case 7:
					words += ('Seven');
				case 8:
					words += ('Eight');
				case 9:
					words += ('Nine');
				default:
					trace("case '" + arr[0] + "': trace ('" + arr[0] + "');");
			}
		}
		// Fifty-eight percent

		if (words.indexOf('-*') != -1) {
			words = words.split('-*').join('');
		}

		return words;
	}
}
