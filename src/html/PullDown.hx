package html;

import js.html.OptionElement;
import js.html.HTMLOptionsCollection;
import js.html.SelectElement;
import js.html.URLSearchParams;
import js.Browser;
import js.Browser.*;

using StringTools;

class PullDown {
	var valueArray:Array<String> = [];
	var textArray:Array<String> = [];

	var callback:Dynamic;
	var callbackArray:Array<Dynamic>;

	var select:SelectElement;

	final keyDefaultValue = 'ccquicknav';

	@:isVar public var hash(get, set):String;
	@:isVar public var param(get, set):String;
	@:isVar public var selected(get, set):Int;

	/**
	 * simple navigation based upon string
	 *
	 * @example
	 * 		var pulldown = new html.PullDown(['one', 'two'], onSelectHandler);
	 * 		function onSelectHandler (e){trace(e);// index}
	 *
	 * @param valueArray
	 * @param callback
	 * @param callbackArray
	 */
	public function new(valueArray:Array<String>, ?callback:Dynamic, ?callbackArray:Array<Dynamic>) {
		this.valueArray = valueArray;
		this.callback = callback;
		this.callbackArray = callbackArray;
		// test();
		// updateURL();
		setup();
	}

	function setup() {
		var div = document.createDivElement();
		div.setAttribute('style', 'position: fixed;display: block;top: 0;');
		div.id = 'ccsketcher';

		// console.log(param);

		select = document.createSelectElement();

		select.id = 'art';
		for (i in 0...valueArray.length) {
			var _valueArray = valueArray[i];
			var name = _valueArray;

			var option = document.createOptionElement();
			option.value = '${name}';
			option.text = '${name}';
			if (name.indexOf(param) != -1)
				option.selected = true;
			select.appendChild(option);
		}

		div.appendChild(select);
		document.body.appendChild(div);

		select.onchange = function(e) {
			var index = select.selectedIndex;
			var options = select.options;
			// console.log(untyped options[index].index);
			// console.log(untyped options[index].text);
			// console.log(Type.getClassName(ccTypeArray[index]));
			// changeHash(index);
			// setupArt();

			param = valueArray[index];

			// trace(param);
			// updateURL();

			if (callback != null) {
				if (callbackArray == null) {
					Reflect.callMethod(callback, callback, [index]);
				} else {
					Reflect.callMethod(callback, callback, callbackArray);
				}
			}
		}
	}

	// ____________________________________ query ____________________________________

	/**
	 * WIP
	 */
	function test() {
		// test url
		window.location.search = 'post=1234&action=edit';
		var urlParams = new URLSearchParams(window.location.search);

		console.log(urlParams.has('post')); // true
		console.log(urlParams.get('action')); // "edit"
		console.log(urlParams.getAll('action')); // ["edit"]
		console.log(urlParams); // "?post=1234&action=edit"
		// console.log(urlParams.append('active', '1')); // "?post=1234&action=edit&active=1"
	}

	/**
	 * WIP
	 */
	function updateURL() {
		console.warn('updateURL');
		trace(param);
		var urlParams = new URLSearchParams(window.location.search);
		trace(urlParams.has(keyDefaultValue));
		if (!urlParams.has(keyDefaultValue)) {
			urlParams.append(keyDefaultValue, valueArray[0]);
			param = valueArray[0];
			trace(param);
		} else {
			urlParams.set(keyDefaultValue, param);
		}
		trace(param);
		// window.history.replaceState({}, '', '${location.pathname}?${urlParams}');
		// window.history.pushState("object or string", "Title", "/new-url");

		// window.location.search = untyped urlParams.toString();
	}

	/**
	 * wip
	 * @param index
	 */
	function setSelected(index:Int) {
		var options:HTMLOptionsCollection = select.options;
		var o:OptionElement = cast options.item(index);
		o.selected = true;
	}

	// ____________________________________ helper ____________________________________

	/**
	 * totally useless class except in my own setup..]
	 *
	 * @example
	 *	 			var arr = PullDown.convertClass(ccTypeArray);
	 *				pulldown = new PullDown(arr, onSelectHandler);
	 *
	 * @param ccTypeArray
	 * @return Array<String>
	 */
	public static function convertClass(ccTypeArray:Array<Class<Dynamic>>):Array<String> {
		var arr:Array<String> = [];
		for (i in 0...ccTypeArray.length) {
			var _ccTypeArray = ccTypeArray[i];
			var name = Type.getClassName(_ccTypeArray);
			arr.push(name);
		}
		return arr;
	}

	// ____________________________________ getter/setter ____________________________________

	function get_param():String {
		return param;
	}

	function set_param(value:String):String {
		return param = value;
	}

	function get_hash():String {
		var _hash = Browser.location.hash;
		hash = _hash.replace("#", "");
		return hash;
	}

	function set_hash(value:String):String {
		location.hash = value;
		return hash = value;
	}

	function get_selected():Int {
		return selected;
	}

	function set_selected(value:Int):Int {
		setSelected(value);
		return selected = value;
	}
}
