package html;

import js.html.ProgressElement;
import js.Browser.*;

class ProgressBar {
	private var _id = "cc-progressbar";

	var progressEl:ProgressElement;

	public function new() {
		create();
	}

	function create() {
		// Get the snackbar DIV
		progressEl = cast document.getElementById(_id);

		// if no #snackbar exists, create it
		if (progressEl == null) {
			var el = document.createProgressElement();
			el.id = _id;
			el.value = 10;
			el.max = 100;
			document.body.appendChild(el);
			progressEl = el;
		}
	}

	function update(currentValue:Float, totalValue:Float) {
		progressEl.value = currentValue;
		progressEl.max = totalValue;
	}
}
