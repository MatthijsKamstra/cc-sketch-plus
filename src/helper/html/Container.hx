package helper.html;

import js.html.DOMElement;
import js.html.Element;
import sketcher.util.EmbedUtil;
import js.html.Node;
import js.Browser.*;

using StringTools;

/**
 * a quick way to generate a bootstrap layout
 *
 * bootstrap styling is added to the page
 *
 * @example
 *
 * 		var str = '.testclass|testid|#testid2';
 *		var container = new helper.html.Container(str);
 *
 *		// or
 *
 *		var container = Container.create(str).isDebug().full();
 *
 */
class Container {
	var _id = 'cc-sketcher-bootstrap-container';
	var attachID = '';
	var layout:String;
	var _isDebug = false;
	var _isAttachedToID = false;
	var _isAttachedToEl = false;

	var attachElement:Element;

	static var _count = 0;

	@:isVar public var _isfullscreen(get, set):Bool;

	@:isVar public var isFull(get, set):Bool;

	@:isVar public var _isNoGutter(get, set):Bool;

	/**
	 * check for `#` if id and `.` for class
	 *
	 * @param str
	 * @param isClear
	 */
	public function new(?str:String = '', ?isClear:Bool = false) {
		layout = str;

		EmbedUtil.bootstrapStyle();

		// WIP clear existing layout/html (clear the body from divs)
		if (isClear) {
			var elems = document.body.getElementsByTagName('div');
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
		// init();
	}

	/**
	 * Container.create(str).full();
	 */
	public static function create(str:String) {
		trace('x');
		var container = new helper.html.Container(str);
		// container.init();
		return container;
	}

	public function full(?isFull:Bool = true) {
		this.isFull = isFull;
		return this;
	}

	public function noGutter() {
		this._isNoGutter = true;
		return this;
	}

	public function fullscreen() {
		this._isfullscreen = true;
		return this;
	}

	public function isDebug(?isDebug:Bool = true) {
		this._isDebug = isDebug;
		return this;
	}

	public function attach() {
		init();
		return this;
	}

	public function attachToID(id) {
		_isAttachedToID = true;
		attachID = id;
		init();
		return this;
	}

	public function attachToElement(el:Element) {
		_isAttachedToEl = true;
		attachElement = el;

		console.log(el);

		init();
		return this;
	}

	function init() {
		var style = getCSS();
		var div = document.createDivElement();
		div.id = '${_id}-${_count}';
		if (_count == 0) {
			div.id = '${_id}';
		}

		if (isFull) {
			div.className = 'container-fluid';
		} else {
			div.className = 'container';
		}

		if (_isfullscreen) {
			div.setAttribute('style', 'padding-left: 0; padding-right: 0;');
		}

		// div.innerHTML = '<!-- test -->';
		if (_isAttachedToID) {
			trace('1');
			document.body.appendChild(div);
		} else if (_isAttachedToEl) {
			trace('2');
			attachElement.appendChild(div);
		} else {
			trace('3');
			var el = document.getElementById(attachID);
			el.innerHTML = '<!-- container -->';
			el.appendChild(div);
		}

		var _arr:Array<String> = layout.split('\n');
		for (i in 0..._arr.length) {
			var row = _arr[i];
			var divRow = document.createDivElement();
			divRow.className = 'row';
			if (_isNoGutter) {
				divRow.classList.add('no-gutters');
			}
			if (_isDebug)
				trace(row);
			var col:Array<String> = row.split('|');
			for (i in 0...col.length) {
				var _col = col[i];
				if (_isDebug)
					trace(_col);
				var divCol = document.createDivElement();
				divCol.className = 'col';
				divRow.appendChild(divCol);
				if (_col != '') {
					var c = document.createDivElement();
					if (_col.startsWith('#')) {
						c.id = _col.replace('#', '');
						style += '${_col}:after{content:"${_col}";}';
					} else if (_col.startsWith(".")) {
						c.className = _col.replace('.', '');
						style += '${_col}:after{content:"${_col}";}';
					} else {
						c.id = _col;
						style += '#${_col}:after{content:"${_col}";}';
					}
					divCol.appendChild(c);
				}
			}
			div.appendChild(divRow);
		}
		_count++;

		if (_isDebug) {
			var css = document.createStyleElement();
			css.appendChild(document.createTextNode(style));
			document.getElementsByTagName("head")[0].appendChild(css);
		}
	}

	// ____________________________________ getter/setter ____________________________________

	function get_isFull():Bool {
		return isFull;
	}

	function set_isFull(value:Bool):Bool {
		return isFull = value;
	}

	function get__isNoGutter():Bool {
		return _isNoGutter;
	}

	function set__isNoGutter(value:Bool):Bool {
		return _isNoGutter = value;
	}

	function get__isfullscreen():Bool {
		return _isfullscreen;
	}

	function set__isfullscreen(value:Bool):Bool {
		return _isfullscreen = value;
	}

	// ____________________________________ css ____________________________________

	function getCSS():String {
		return '
.col{
    min-height:20px;
    padding-top: .75rem;
    padding-bottom: .75rem;
    background-color: rgba(86,61,124,.15);
    border: 1px solid rgba(86,61,124,.2);
}
';
	}
}
