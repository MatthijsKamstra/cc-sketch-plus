package sketcher.util;

import js.html.DOMParser;
import js.html.LinkElement;
import js.Browser.document;

using StringTools;

class EmbedUtil {
	public function new() {
		// your code
	}

	public static function check(id:String):Bool {
		if (document.getElementById(id) != null) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * @url 	https://github.com/mrdoob/stats.js/
	 *
	 * @example
	 * 				sketcher.util.EmbedUtil.stats();
	 */
	public static function stats() {
		untyped __js__("var script = document.createElement('script');script.onload = function() {var stats = new Stats();document.body.appendChild(stats.dom);requestAnimationFrame(function loop() {stats.update();requestAnimationFrame(loop)});};script.src = '//mrdoob.github.io/stats.js/build/stats.min.js';document.head.appendChild(script);");

		/*
			var script = document.createElement('script');
			script.onload = function() {
				var stats = new Stats();
				document.body.appendChild(stats.dom);
				requestAnimationFrame(function loop() {
					stats.update();
					requestAnimationFrame(loop)
				});
			};
			script.src = '//mrdoob.github.io/stats.js/build/stats.min.js';
			document.head.appendChild(script);
		 */
	}

	/**
	 * [Description]
	 * @param id
	 * @param src
	 * @param callback
	 * @param callbackArray
	 */
	public static function script(id:String, src:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		// trace('${toString()} embedSocketScript');
		var el:js.html.ScriptElement = document.createScriptElement();
		el.id = id;
		el.src = src;
		el.crossOrigin = 'anonymous'; // do we need this?
		el.onload = function() {
			// Zip.isZipLoaded = true; // embedding is done
			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, [id]);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}
		}
		document.body.appendChild(el);
	}

	public static function stylesheet(id:String, src:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		var el:js.html.LinkElement = document.createLinkElement();
		el.id = id;
		el.rel = 'stylesheet';
		el.href = src;
		// el.crossOrigin = 'anonymous'; // do we need this?
		el.onload = function() {
			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, ['id']);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}
		}
		document.head.appendChild(el);
	}

	public static function bootstrapStylesheet(id:String, src:String, integrity:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		var el:js.html.LinkElement = document.createLinkElement();
		el.id = id;
		el.rel = 'stylesheet';
		el.href = src;
		el.integrity = integrity;
		el.crossOrigin = 'anonymous'; // do we need this?
		el.onload = function() {
			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, [id]);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}
		}
		document.head.appendChild(el);
	}

	public static function bootstrapScript(id:String, src:String, integrity:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		var el:js.html.ScriptElement = document.createScriptElement();
		el.id = id;
		// el.rel = 'stylesheet';
		el.src = src;
		el.integrity = integrity;
		el.crossOrigin = 'anonymous'; // do we need this?
		el.onload = function() {
			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, [id]);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}
		}
		document.head.appendChild(el);
	}

	// ____________________________________ scripts ____________________________________

	/**
	 * @example
	 * 					sketcher.util.EmbedUtil.quicksettings();
	 * @param callback
	 * @param callbackArray
	 */
	public static function quicksettings(?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		script('quicksettings', 'https://cdn.jsdelivr.net/quicksettings/3.0.2/quicksettings.min.js', callback, callbackArray);
	}

	/**
	 * @example
	 * 					sketcher.util.EmbedUtil.datgui();
	 * @param callback
	 * @param callbackArray
	 */
	public static function datgui(?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		script('datgui', 'https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.7.6/dat.gui.min.js', callback, callbackArray);
	}

	//
	// ____________________________________ styling ____________________________________

	/**
	 * @example
	 * 					sketcher.util.EmbedUtil.sanitize();
	 * @param callback
	 * @param callbackArray
	 */
	public static function sanitize(?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		stylesheet('sanitize', 'https://cdnjs.cloudflare.com/ajax/libs/10up-sanitize.css/8.0.0/sanitize.css', callback, callbackArray);
	}

	/**
	 * <!-- Ficons, A Simple, Open-Source, Drop-In Alternative for Font Awesome Icons  -->
	 * @example
	 * 					sketcher.util.EmbedUtil.ficons();
	 *
	 * @param callback
	 * @param callbackArray
	 */
	public static function ficons(?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		stylesheet('ficons', 'https://cdn.jsdelivr.net/npm/ficons@1.1.52/dist/ficons/font.css', callback, callbackArray);
	}

	// <!-- Source® Sans Pro, Adobe's first open source typeface family, was designed by Paul D. Hunt. -->
	// <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700&display=swap" rel="stylesheet">
	//
	// ____________________________________ bootstrap ____________________________________

	/**
	 * @example
	 * 						sketcher.util.EmbedUtil.bootstrap();
	 *
	 * @param callback
	 * @param callbackArray
	 */
	public static function bootstrap(?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		bootstrapStylesheet("bootstrap-stylesheet", "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css",
			"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh");
		bootstrapScript("bootstrap-jquery", "https://code.jquery.com/jquery-3.4.1.slim.min.js",
			"sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n");
		bootstrapScript("bootstrap-popper", "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js",
			"sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo");
		bootstrapScript("bootstrap-bootstrap", "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js",
			"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6");
	}

	/**
	 * [Description]
	 *
	 * @exampe
	 * 		Text.embedGoogleFont('Press+Start+2P', onEmbedHandler);
	 *
	 * @param family	name given after `...css?family=` (example: Press+Start+2P)
	 * @param callback
	 * @param callbackArray
	 */
	public static function embedGoogleFont(family:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		// trace('embedGoogleFont');
		var _id = 'embededGoogleFonts';
		var _url = 'https://fonts.googleapis.com/css?family=';
		var link:LinkElement = cast document.getElementById(_id);
		if (link != null) {
			var temp = link.href.replace(_url, '');
			family = temp + '|' + family;
		} else {
			link = document.createLinkElement();
		}
		if (callbackArray == null)
			callbackArray = [family];
		link.href = '${_url}${family}';
		link.rel = "stylesheet";
		link.id = _id;
		link.onload = function() {
			if (callback != null)
				Reflect.callMethod(callback, callback, callbackArray);
		}
		document.head.appendChild(link);
	}
}