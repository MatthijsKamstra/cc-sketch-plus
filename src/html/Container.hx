package html;

import js.html.Document;
import js.Browser.*;

class Container {
	var layout:String;
	var _id = 'cc-bootstrap-container';

	static var _count = 0;

	public function new(str:String) {
		layout = str;
		init();
	}

	function init() {
		var div = document.createDivElement();
		div.id = '${_id}-${_count}';
		div.className = 'container';
		// div.innerHTML = '<!-- test -->';
		document.body.appendChild(div);

		var _arr:Array<String> = layout.split('\n');
		for (i in 0..._arr.length) {
			var row = _arr[i];
			var divRow = document.createDivElement();
			divRow.className = 'row';
			trace(row);
			var col:Array<String> = row.split('|');
			for (i in 0...col.length) {
				var _col = col[i];
				trace(_col);
				if (_col == '') {
					var divCol = document.createDivElement();
					divCol.className = 'col';
					divRow.appendChild(divCol);
				} else {
					var divCol = document.createDivElement();
					divCol.className = 'col';
					divRow.appendChild(divCol);

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
