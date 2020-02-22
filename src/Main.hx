package;

import examples.ExContainer;
import html.PullDown;
import js.Browser.*;
import Sketcher.Globals.*;

using StringTools;

class Main {
	var count:Int;
	var hash:String;
	var ccTypeArray:Array<Class<Dynamic>> = [
		//
		examples.ExAll, //
		examples.ExCircles, //
		examples.ExRectangle, //
		examples.ExLine, //
		examples.ExImage, //
		examples.ExGui, //
		examples.ExGroup, //
		examples.ExText, //
		examples.ExEllipse, //
		examples.ExGradient, //
		examples.ExPolyline, //
		examples.ExBackground, //
		examples.ExContainer, //
	];

	var pulldown:PullDown;

	public function new() {
		// console.log('START :: main');
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${sketcher.App.NAME} Dom ready :: build: ${sketcher.App.getBuildDate()}');

			var arr = PullDown.convertClass(ccTypeArray);
			pulldown = new PullDown(arr, onSelectHandler);

			// var cc = new examples.All();
			setupArt();
			setupNav();
		});
	}

	function setupArt() {
		// get hash from url
		hash = js.Browser.location.hash;
		hash = hash.replace('#', '');

		var clazz = Type.resolveClass('examples.${hash}');
		if (clazz == null) {
			// make sure if it's not in the list, show the latest Sketch
			clazz = ccTypeArray[ccTypeArray.length - 1];
		}
		// trace('hash: ' + hash);
		// trace('clazz: ' + clazz);

		count = ccTypeArray.indexOf(clazz);
		var cc = Type.createInstance(clazz, []);

		changeHash();
	}

	function setupNav() {
		// make sure the browser updates after changing the hash
		window.addEventListener("hashchange", function() {
			location.reload();
		}, false);

		// use cursor key lef and right to switch sketches
		window.addEventListener(KEY_DOWN, function(e:js.html.KeyboardEvent) {
			switch (e.key) {
				case 'ArrowRight':
					count++;
				case 'ArrowLeft':
					count--;
				case 'ArrowUp':
					count = ccTypeArray.length - 1;
				case 'ArrowDown':
					count = 0;
					// default : trace ("case '"+e.key+"': trace ('"+e.key+"');");
			}
			changeHash();
		}, false);
	}

	function changeHash(?index:Int) {
		var _count = (index == null) ? count : index;
		location.hash = Type.getClassName(ccTypeArray[_count]).replace('examples.', '');
		if (pulldown != null)
			pulldown.selected = _count;
	}

	function onSelectHandler(e:Int) {
		changeHash(e);
	}

	static public function main() {
		var app = new Main();
	}
}
