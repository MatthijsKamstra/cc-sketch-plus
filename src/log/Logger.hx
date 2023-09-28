package log;

import log.Colors.*;

/**
 *
 * - https://en.wikipedia.org/wiki/ANSI_escape_code
 * - https://github.com/haxiomic/console.hx/blob/master/Console.hx
 * - https://stackoverflow.com/questions/5762491/how-to-print-color-in-console-using-system-out-println
 *
 *
 * @example
 * import log.Logger.*;
 *
 *		setup(); // replace default Haxe trace();
 * 		log("this is a log message");
 *		warn("this is a warn message");
 *		info("this is a info message");
 */
class Logger {
	public static final TAB = '    ';

	/**
	 * @example		log.Logger.setup();
	 */
	public static function setup() {
		// now we are going to overwrite the default trace with our own
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) {
			var str = '${BLUE} → ${RED_UNDERLINED}${infos.fileName}:${infos.lineNumber} ${RED_BOLD}${v}${RESET}';
			Sys.println(str);
		}
	}

	public static inline function log(v:Dynamic, ?tab = 0) {
		// Sys.println('> ' + v);
		var t:String = '';
		for (i in 0...tab)
			t += TAB;
		Sys.println('${t}${BLUE}→ ${WHITE}${v}${RESET}');
	}

	/**
	 * muted log
	 * @param v		message you want to log
	 * @param tab   number of tabs (default:1)
	 */
	public static inline function mute(v:Dynamic, ?tab = 1) {
		var t:String = '';
		for (i in 0...tab)
			t += TAB;
		Sys.println('${t}${GRAY}→ ${v}${RESET}');
	}

	public static inline function info(v:Dynamic, ?tab = 0) {
		var t:String = '';
		for (i in 0...tab)
			t += TAB;
		Sys.println('${t}${BLUE}♥ ${GREEN}${v}${RESET}');
	}

	public static inline function warn(v:Dynamic, ?tab = 0, ?infos:haxe.PosInfos) {
		var t:String = '';
		for (i in 0...tab)
			t += TAB;
		Sys.println('${t}${BLUE}⚠️ ${BLACK}${RED_BACKGROUND}${v} [${infos.fileName}:${infos.lineNumber}]${RESET}');
	}

	public static inline function wip(v:Dynamic, ?tab = 0) {
		var t:String = '';
		for (i in 0...tab)
			t += TAB;
		Sys.println('${t}${BLUE}🚧 WIP: ${BLACK}${WHITE_BACKGROUND}${v}${RESET}');
	}

	public static inline function progress(v:Dynamic) {
		Sys.println('${BLUE}🔋 ${RED}${v}${RESET}');
	}
}
