package;

import cc.model.constants.App;
import js.Browser.*;
import svg.*;

using StringTools;

class MainSVG {
	var count:Int;
	var hash:String;
	var ccTypeArray:Array<Class<Dynamic>> = [
		// CC004, CC011, CC012, CC017, CC018, CC030, CC031, CC032, CC035, CC045, CC057, CC058, CC059a, CC061, CC062, CC066, CC067, CC069,CC030,
		// CC032, CC027,	CC031,
		// Calendar,
		// CC004,
		// CC011,
		// CC012,
		// CC017,
		// CC018,
		// CC035Simple,
		// CC045,
		// CC059a,
		// CC062,
		// CC066,
		// CC067,
		// CC069,
		// PMECube2,
		// PMEDots,
		// PMEMorseCode,
		// PMEMorseCodeSquare,
		// PMEPixels,
	];

	// CC027 is an image to vector convert via pixels

	public function new() {
		// console.log('START :: main');
		document.addEventListener("DOMContentLoaded", function(event) {
			console.log('${App.NAME} Dom ready');
			console.log('${sketcher.App.NAME} (SVG) Dom ready :: build: ${sketcher.App.getBuildDate()}');

			// var cc = new svg.Calendar();
			setupArt();
			setupNav();
		});
	}

	function setupArt() {
		// get hash from url
		hash = js.Browser.location.hash;
		hash = hash.replace('#', '');

		var clazz = Type.resolveClass('${hash}');
		if (clazz == null) {
			// make sure if it's not in the list, show the latest Sketch
			clazz = ccTypeArray[ccTypeArray.length - 1];
		}
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
		window.addEventListener('KEY_DOWN', function(e:js.html.KeyboardEvent) {
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

	function changeHash() {
		location.hash = Type.getClassName(ccTypeArray[count]).replace('art.', '');
	}

	static public function main() {
		var app = new MainSVG();
	}
}
