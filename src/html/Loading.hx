package html;

import js.Browser.*;
import js.html.*;

class Loading extends CSSinjector {
	var _id = 'cc-loading';
	var el:js.html.DivElement;

	/**
	 * create a throbber loader, without progress
	 *
	 * @param isVisible 	start visible or not
	 */
	public function new(?isVisible:Bool = false) {
		super(css(), 'inject-$_id');

		// use ficons loading icons
		sketcher.util.EmbedUtil.ficons(create, [isVisible]);
	}

	function create(isVisible:Bool) {
		// trace('Loading.create($isVisible)');

		// Get the snackbar DIV
		el = cast document.getElementById(_id);

		// if no `_id` exists, create it
		if (el == null) {
			var div = document.createDivElement();
			div.id = _id;
			div.innerHTML = '<i class="fa fa-refresh fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span>';
			document.body.appendChild(div);
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
	/* Add animation: Take 0.5 seconds to fade in and out the loading.
	However, delay the fade out process for 2.5 seconds */
    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
	animation: fadein 0.5s, fadeout 0.5s 2.5s;
	transition: background-color 5;
}
#${_id}.hide {
    /* visibility: visible; Show the loading */
	/* Add animation: Take 0.5 seconds to fade in and out the loading.
	However, delay the fade out process for 2.5 seconds */
    -webkit-animation: fadeout 0.5s;
    animation: fadeout 0.5s;
}
';

	}
}
