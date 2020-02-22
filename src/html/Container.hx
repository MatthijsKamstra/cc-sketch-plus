package html;

import js.html.Document;
import js.Browser.*;

using StringTools;

class Container {
	var _id = 'cc-sketcher-bootstrap-container';
	var layout:String;
	var isDebug = false;

	static var _count = 0;

	/**
	 * check for `#` if id and `.` for class
	 *
	 * @param str
	 * @param isClear
	 */
	public function new(?str:String = '', ?isClear:Bool = false) {
		layout = str;
		var elems = document.body.getElementsByTagName('div');
		if (isClear) {
			for (i in 0...elems.length) {
				var _el = elems[i];
				if (_el == null)
					return;
				// trace(_el);
				// if (_el.id.toLowerCase().indexOf('cc-') == -1) {
				// 	_el.parentElement.removeChild(_el);
				// }
			}

			document.body.innerHTML = '';
		}
		init();
	}

	function init() {
		var div = document.createDivElement();
		div.id = '${_id}-${_count}';
		if (_count == 0)
			div.id = '${_id}';

		div.className = 'container';
		// div.innerHTML = '<!-- test -->';
		document.body.appendChild(div);

		var _arr:Array<String> = layout.split('\n');
		for (i in 0..._arr.length) {
			var row = _arr[i];
			var divRow = document.createDivElement();
			divRow.className = 'row';
			if (isDebug)
				trace(row);
			var col:Array<String> = row.split('|');
			for (i in 0...col.length) {
				var _col = col[i];
				if (isDebug)
					trace(_col);
				var divCol = document.createDivElement();
				divCol.className = 'col';
				divRow.appendChild(divCol);
				if (_col != '') {
					var c = document.createDivElement();
					if (_col.startsWith('#')) {
						c.id = _col.replace('#', '');
					} else if (_col.startsWith(".")) {
						c.className = _col.replace('.', '');
					} else {
						c.id = _col;
					}
					divCol.appendChild(c);
				}
			}
			div.appendChild(divRow);
		}
		_count++;
	}
}
