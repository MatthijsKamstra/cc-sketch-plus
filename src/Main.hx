package;

import sketcher.App;
import js.Browser.*;

class Main {
	public function new() {
		document.addEventListener("DOMContentLoaded", function(event) {
			// DOM ready
			console.log('${App.NAME} :: build: ${App.getBuildDate()}');
		});
	}

	static public function main() {
		var app = new Main();
	}
}
