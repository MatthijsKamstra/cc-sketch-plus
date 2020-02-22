package html;

import js.html.ProgressElement;
import js.Browser.*;

class ProgressBar extends CSSinjector {
	var _id = "cc-progressbar";

	var progress:ProgressElement;
	var el:js.html.DivElement;

	/**
	 * create a  progress
	 *
	 * @param isVisible 	start visible or not
	 */
	public function new(?isVisible:Bool = false) {
		super(css(), 'inject-$_id');
		create(isVisible);
	}

	function create(isVisible:Bool) {
		el = cast document.getElementById(_id);

		// if no #snackbar exists, create it
		if (el == null) {
			var div = document.createDivElement();
			div.id = _id;
			document.body.appendChild(div);

			progress = document.createProgressElement();
			// progress.id = _id;
			progress.value = 10;
			progress.max = 100;
			div.appendChild(progress);

			el = div;
		}

		if (isVisible) {
			// Add the "show" class to DIV
			el.className = 'show';
		} else {
			el.className = "hide";
		}
	}

	// ____________________________________ public ____________________________________
	public function update(currentValue:Float, totalValue:Float) {
		progress.value = currentValue;
		progress.max = totalValue;
	}

	public function hide() {
		el.className = 'hide';
	}

	public function show() {
		el.className = 'show';
	}

	public function remove() {
		var parent = el.parentElement;
		parent.removeChild(el);
	}

	// ____________________________________ inject css code ____________________________________

	function css():String {
		return '
#${_id} {
    visibility: hidden; /* Hidden by default */
    height: 100%;
    width: 100%;
    z-index: 700; /* seems like a good number... */
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.5);
	display: flex;
    align-items: center;
    justify-content: center;
}

#${_id}.show {
    visibility: visible; /* Show the loading */
	transition: background-color ease-out;
}
#${_id}.hide {
	/* visibility: visible; Show the loading */
	transition: background-color ease-out;
}
';

	}
}
