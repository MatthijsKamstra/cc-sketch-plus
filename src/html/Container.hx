package html;

import js.html.Document;
import js.Browser.*;

class Container {
	var _id = 'cc-bootstrap-container';
	var layout:String;
	var isDebug = false;

	static var _count = 0;

	public function new(?str:String = '', ?isClear:Bool = false) {
		layout = str;
		var elems = document.body.getElementsByTagName("*");
		if (isClear) {
			// for (i in 0...elems.length) {
			// 	var _el = elems[i];
			// 	if (_el == null)
			// 		return;
			// 	trace(_el);
			// 	if (_el.id.toLowerCase().indexOf('cc-') == -1) {
			// 		_el.parentElement.removeChild(_el);
			// 	}
			// }

			document.body.innerHTML = '';
		}
		init();
	}

	function init() {
		var div = document.createDivElement();
		if (_count == 0) {
			div.id = '${_id}';
		} else {
			div.id = '${_id}-${_count}';
		}
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
					c.id = _col;
					divCol.appendChild(c);
				}
			}
			div.appendChild(divRow);
		}
		_count++;
	}
}
