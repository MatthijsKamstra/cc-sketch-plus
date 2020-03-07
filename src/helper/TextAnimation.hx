package helper;

import js.Browser.*;
import sketcher.lets.easing.IEasing;
import sketcher.lets.easing.Quart;

class TextAnimation {
	static var COUNT = 0;

	var ISDEBUG:Bool = false;
	var id = 0;

	var timer:Int;
	var message:String;
	var animationVar:String;

	var callback:Dynamic;
	var callbackArray:Array<Dynamic>;

	public var onComplete:Dynamic;
	public var onCompleteArray:Array<Dynamic>;

	@:isVar public var ease(get, set):IEasing;

	@:isVar public var duration(get, set):Int = 3000;

	@:isVar public var hussle(get, set):String = 'abcdefghijklmnopqrstuvwxyz';

	/**
	 *
	 * @example
	 * 			var ani = new helper.TextAnimation('[mck]', function(str:String) {
	 *				warningText2 = str;
	 *			}););
	 *			ani.duration = 5000;
	 *			ani.ease = Linear.easeNone;
	 * 			ani.setHussle('abcdefghijklmnopqrstuvwxyz1234567890');
	 * 			ani.start();
	 *
	 *
	 * @param message
	 * @param callback
	 * @param callbackArray
	 */
	public function new(message:String, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		this.message = message;
		this.callback = callback;
		this.callbackArray = callbackArray;
		this.ease = Quart.easeOut;
		this.id = COUNT;
		COUNT++;
	}

	// ____________________________________ set ____________________________________

	public function setHussle(str:String) {
		this.hussle = str;
	}

	public function durationMS(ms:Int) {
		this.duration = ms;
	}

	// ____________________________________ start ____________________________________

	public function start() {
		var interval = 50; // 0.5 second
		var startTime = Date.now().getTime();

		var _charArray = hussle.split('');

		var maxx = 100;

		var originalString = this.message;
		var originalArr = originalString.split('');

		var animationArray:Array<Array<String>> = [];

		for (i in 0...originalArr.length) {
			var _tempArray = [];
			for (i in 0...maxx + 1) {
				var _char = _charArray[Std.random(_charArray.length)];
				_tempArray.push(_char);
			}
			animationArray.push(_tempArray);
		}
		// trace(animationArray);

		timer = window.setInterval(function() {
			// trace(startTime);

			var currentTime = Date.now().getTime();
			var timepast = (currentTime - startTime);
			var percentage = (timepast / duration);

			// var ease = Quart.easeOut;
			var counter = this.ease.calculate(percentage);

			var value = Std.int(maxx * counter);

			this.animationVar = '';
			for (i in 0...animationArray.length) {
				var countBack = (animationArray.length - 1) - i;

				var delay = 0.5 / originalArr.length;
				if (percentage >= (1 - (countBack * delay))) {
					this.animationVar += originalArr[i];
				} else {
					this.animationVar += animationArray[i][value];
				}
			}

			// trace(this.animationVar);
			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, [this.animationVar]);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}

			if (percentage >= 1) {
				window.clearInterval(timer);

				if (ISDEBUG)
					console.info('Animation done ${id}');

				if (onComplete != null) {
					if (onCompleteArray == null) {
						Reflect.callMethod(onComplete, onComplete, [this.id]);
					} else {
						Reflect.callMethod(onComplete, onComplete, onCompleteArray);
					}
				}
			}
		}, interval);
	}

	// ____________________________________ getter/setter ____________________________________

	function get_ease():IEasing {
		return ease;
	}

	function set_ease(value:IEasing):IEasing {
		return ease = value;
	}

	function get_duration():Int {
		return duration;
	}

	function set_duration(value:Int):Int {
		return duration = value;
	}

	function get_hussle():String {
		return hussle;
	}

	function set_hussle(value:String):String {
		return hussle = value;
	}
}
