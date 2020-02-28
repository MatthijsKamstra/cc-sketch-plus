package html;

import js.Browser.*;

class CCNav {
	var valueArray:Array<String>;

	public function new(valueArray:Array<String>) {
		sketcher.util.EmbedUtil.ccnav(function() {
			console.info('CCNav: delay 1 second to add ${valueArray.length} to nav');
			haxe.Timer.delay(onCompleteHandler, 1000); // /doc/nav.html
		});
		this.valueArray = valueArray;
	}

	function onCompleteHandler() {
		var div = document.getElementById('storage');
		div.innerHTML = '';

		var ul = document.createUListElement(); // <ul>
		for (i in 0...this.valueArray.length) {
			var _arr = this.valueArray[i];

			var li = document.createLIElement(); // <li>
			var a = document.createAnchorElement(); // <a href>
			var arr = _arr.split(".");
			var hashLink = arr[arr.length - 1];

			a.href = '#${hashLink}';
			a.text = '${_arr}';

			li.appendChild(a);
			ul.appendChild(li);

			// console.log(a);
		}
		// console.log(li);
		// console.log(ul);
		// console.log(div);
		div.appendChild(ul);
	}
}
