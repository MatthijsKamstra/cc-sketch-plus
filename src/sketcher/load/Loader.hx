package sketcher.load;

import haxe.Timer;
import js.Browser.*;
import js.html.Image;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;
import js.html.XMLHttpRequestResponseType;
import sketcher.util.MathUtil;

/**
 * 	var load = Loader.create().add(filePath).isDebug(false)
 * 		.onComplete((e) -> {
 *			trace(e);
 *		}).onProgress((e) -> {
 *			trace(e);
 *		}).onUpdate((e) -> {
 *			trace(e);
 *		}).onError((e) -> {
 *			trace(e);
 *		}).onInit((e) -> {
 *			trace(e);
 *		});
 */
/**
 *
 * onprogress doesn't work with text yet
 */
class Loader {
	@:isVar public var _id(get, set):String;
	@:isVar public var _loadingArray(get, set):Array<LoaderObj> = [];
	public var completeArray:Array<LoaderObj> = [];
	@:isVar public var _isDebug(get, set):Bool = false;

	var _onComplete:Dynamic;
	var _onCompleteParams:Array<Dynamic>;
	var _onUpdate:Dynamic;
	var _onUpdateParams:Array<Dynamic>;
	var _onProgress:Dynamic;
	var _onProgressParams:Array<Dynamic>;
	var _onError:Dynamic;
	var _onErrorParams:Array<Dynamic>;
	var _onInit:Dynamic;
	var _onInitParams:Array<Dynamic>;
	var _loadCounter = 0;

	/**
	 * create a file loader
	 *
	 * @example
	 * 		import  sketcher.load;
	 * 		var load = Loader.create().add(filename).load();
	 *
	 * @param id  (optional) id of the loader, otherwise an id is created
	 */
	public function new(?id:String) {
		if (id == null) {
			this._id = '${toString()}_${Date.now().getTime()}';
		} else {
			this._id = id;
		}
	}

	/**
	 * create a file loader
	 *
	 * @example
	 * 		import cc.tool.Loader;
	 * 		var load = Loader.create().add(filename).load();
	 *
	 * @param id  (optional) id of the loader, otherwise an id is created
	 * @return Loader
	 */
	static inline public function create(?id:String):Loader {
		var loader = new Loader(id);
		return loader;
	}

	// ____________________________________ properties ____________________________________

	/**
	 * @example
	 * 		var load = Loader.create().add('data/CC-Sketcher-MatthijsKamstra-1582218820239_.json').load().isDebug();
	 *
	 * @param isDebug
	 * @return Loader
	 */
	inline public function isDebug(?isDebug:Bool = true):Loader {
		this._isDebug = isDebug;
		return this;
	}

	/**
	 * add a file to the loading queue
	 *
	 * @param path 	to the file
	 * @param func	oncomplete function when this file is loaded
	 * @param type	if you need this ...
	 * @return Loader
	 */
	inline public function add(path:String, ?func:LoaderObj->Void, ?type:FileType):Loader {
		var _type = (type == null) ? fileType(path) : type;
		var _obj:LoaderObj = {
			path: path,
			type: _type,
			time: {},
			filesize: {},
			func: func
		};
		if (_isDebug)
			console.debug(_obj);
		this._loadingArray.push(_obj);
		return this;
	}

	/**
	 * every loader needs this, otherwise the loading won't start
	 *
	 * @example
	 * 		var load = Loader.create().add(filename).load();
	 *
	 * @return Loader
	 */
	inline public function load():Loader {
		if (_isDebug)
			console.debug('start loading');

		loadingHandler();
		return this;
	}

	/**
	 * when all files are loaded call this function
	 *
	 * @example:
	 * 		var load = Loader.create().isDebug(true).add('smoelenboek.csv').onComplete(onCompleteHandler).load();
	 *
	 * 		function onCompleteHandler(completeArray:Array<LoaderObj>) {
	 *			trace('onCompleteHandler: ' + completeArray.length);
	 *				var l:LoaderObj = completeArray[0];
	 *				// console.log(l);
	 *				console.log(l.time);
	 *				console.log(l.filesize);
	 *				console.log(l.json.data.length);
	 *		}
	 *
	 * @param func		oncomplete function
	 * @param arr		oncomplete extra parameters
	 * @return Loader
	 */
	inline public function onComplete(func:Array<LoaderObj>->Void, ?arr:Array<Dynamic>):Loader {
		this._onComplete = func;
		this._onCompleteParams = arr;
		return this;
	}

	inline public function onUpdate(func:Dynamic, ?arr:Array<Dynamic>):Loader {
		this._onUpdate = func;
		this._onUpdateParams = arr;
		return this;
	}

	/**
	 *
	 * @example:
	 * 		var load = Loader.create().add('test.json').onComplete(onCompleteHandler).onProgress(onProgressHandler).load();
	 *		function onProgressHandler(current:Float, total:Float, pct:Float) {
	 *			console.log(current);
	 *			console.log(total);
	 *			console.log(pct);
	 *		}
	 *
	 * @param func
	 * @param arr		might be a little weird...
	 * @return Loader
	 */
	inline public function onProgress(func:Dynamic, ?arr:Array<Dynamic>):Loader {
		this._onProgress = func;
		this._onProgressParams = arr;
		return this;
	}

	inline public function onError(func:Dynamic, ?arr:Array<Dynamic>):Loader {
		this._onError = func;
		this._onErrorParams = arr;
		return this;
	}

	inline public function onInit(func:Dynamic, ?arr:Array<Dynamic>):Loader {
		this._onInit = func;
		this._onInitParams = arr;
		return this;
	}

	/**
	 * lets start simple
	 * 		expect : 'foo/bar/file.json'
	 *
	 * @param path
	 * @return FileType
	 */
	function fileType(path:String):FileType {
		var type:FileType = Unknown;
		var ext = path.split('.')[path.split('.').length - 1];

		switch (ext.toLowerCase()) {
			case 'jpg', 'jpeg':
				type = JPG;
			case 'gif':
				type = Gif;
			case 'png':
				type = Png;
			case 'json':
				type = Json;
			case 'xml':
				type = Xml;
			case 'txt':
				type = Txt;
			case 'csv':
				type = Csv;
			case 'svg':
				type = Svg;
			case _:
				type = Unknown;
		}

		if (_isDebug) {
			console.log(ext);
		}

		return type;
	}

	function loadingHandler() {
		if (_loadCounter >= _loadingArray.length) {
			if (_isDebug)
				console.debug('${toString()} :: Loading queue is done');
			if (_isDebug)
				console.debug('show completed array: ' + completeArray);
			if (_isDebug)
				console.debug('length of complete files: ' + completeArray.length);
			if (Reflect.isFunction(_onComplete))
				Timer.delay(() -> {
					Reflect.callMethod(_onComplete, _onComplete, [completeArray]);
				}, 1); // make sure progress is update
			return;
		}

		// create the image used
		var _l:LoaderObj = _loadingArray[_loadCounter];
		switch (_l.type) {
			case JPEG, JPG, Png, Gif, Img:
				imageLoader(_l);
			case Json:
				textLoaderBig(_l);
			case Txt, Xml, Svg, Csv:
				textLoader(_l);
			case _:
				console.warn('not sure what this type is?: "${_l.path}"');
		}
	}

	function imageLoader(_l:LoaderObj) {
		var _img = new Image();
		_img.crossOrigin = "Anonymous";
		_img.src = _l.path;
		_img.onload = function() {
			if (_isDebug) {
				trace('image source: ' + _img.src);
				trace('image width: ' + _img.width);
				trace('image height: ' + _img.height);
			}
			if (_isDebug)
				trace('complete array length: ' + completeArray.length);
			_l.image = _img;
			completeArray.push(_l);
			if (_isDebug)
				trace('complete array: ' + completeArray);
			if (_isDebug)
				trace('complete array length: ' + completeArray.length);

			if (Reflect.isFunction(_l.func))
				Reflect.callMethod(_l.func, _l.func, [_l]);
			if (Reflect.isFunction(_onUpdate))
				Reflect.callMethod(_onUpdate, _onUpdate, [_img]);
			_loadCounter++;
			loadingHandler();
		}

		_img.onerror = function() {
			if (Reflect.isFunction(_onError))
				Reflect.callMethod(_onError, _onError, [_img]);
			_loadCounter++;
			loadingHandler();
		}

		_img.onprogress = function() {
			if (Reflect.isFunction(_onProgress))
				Reflect.callMethod(_onProgress, _onProgress, [_img]);
		}
	}

	function textLoader(_l:LoaderObj) {
		var url = _l.path;
		_l.time.start = Date.now();
		var req = new haxe.Http(url);
		// req.setHeader('Content-Type', 'application/json');
		// req.setHeader('auth', '${App.TOKEN}');

		// alert('This file size is: ' + this.files[0].size/1024/1024 + "MB");

		req.onData = function(data:String) {
			// console.log(req.responseBytes);
			_l.filesize.bytes = req.responseBytes.length;
			_l.filesize.KiB = req.responseBytes.length / 1024;
			_l.filesize.MiB = req.responseBytes.length / 1024 / 1024;
			_l.filesize.GiB = req.responseBytes.length / 1024 / 1024 / 1024;

			// trace(MathUtil.formatByteSize(req.responseBytes.length));
			// trace(MathUtil.formatByteSizeString(req.responseBytes.length));

			try {
				// console.info(data);
				_l.str = data;
				_l.time.end = Date.now();
				_l.time.durationMS = _l.time.end.getTime() - _l.time.start.getTime();
				_l.time.durationS = (_l.time.end.getTime() - _l.time.start.getTime()) / 1000;
				if (_l.type == Json) {
					_l.json = haxe.Json.parse(data);
				} else {
					_l.json = '';
				}
				completeArray.push(_l);

				if (Reflect.isFunction(_l.func))
					Reflect.callMethod(_l.func, _l.func, [_l]);

				if (Reflect.isFunction(_onUpdate))
					Reflect.callMethod(_onUpdate, _onUpdate, ['_img']);

				_loadCounter++;

				loadingHandler();
			} catch (e:Dynamic) {
				if (_isDebug)
					trace(e);

				if (Reflect.isFunction(_onError))
					Reflect.callMethod(_onError, _onError, [e]);

				_loadCounter++;
				loadingHandler();
			}
		}
		req.onError = function(error:String) {
			if (_isDebug)
				console.error('error: $error, $url');

			if (Reflect.isFunction(_onError))
				Reflect.callMethod(_onError, _onError, [error]);

			_loadCounter++;
			loadingHandler();
		}
		req.onStatus = function(status:Int) {
			if (_isDebug)
				console.debug('status: $status');
		}
		req.request(false); // false=GET, true=POST

		if (Reflect.isFunction(_onInit))
			Reflect.callMethod(_onInit, _onInit, ['start loading file']);
	}

	function textLoaderBig(_l:LoaderObj) {
		var url = _l.path;
		_l.time.start = Date.now();
		var xmlHTTP = new XMLHttpRequest();
		xmlHTTP.open('GET', url, true);
		switch (_l.type) {
			case FileType.JSON, FileType.Json:
				xmlHTTP.responseType = XMLHttpRequestResponseType.JSON;
			case FileType.Svg:
				xmlHTTP.responseType = XMLHttpRequestResponseType.TEXT;
			default:
				xmlHTTP.responseType = XMLHttpRequestResponseType.TEXT;
				console.warn("case '" + _l.type + "': trace ('" + _l.type + "');");
		}
		xmlHTTP.onload = function(e) {
			// console.log('a');
			var data = xmlHTTP.response;
			// console.log('b');
			// console.log(data);
			// console.log(e);
			// console.log(e.total);
			// console.log(e.timeStamp);

			_l.filesize.bytes = e.total;
			_l.filesize.KiB = e.total / 1024;
			_l.filesize.MiB = e.total / 1024 / 1024;
			_l.filesize.GiB = e.total / 1024 / 1024 / 1024;

			// console.log('c');
			_l.str = data;
			_l.data = data;
			_l.time.end = Date.now();
			_l.time.durationMS = _l.time.end.getTime() - _l.time.start.getTime();
			_l.time.durationS = (_l.time.end.getTime() - _l.time.start.getTime()) / 1000;

			// console.log('d');
			// with big files this is a blocker... might not be the best place to do this
			// if (_l.type == Json) {
			// 	_l.json = haxe.Json.parse(data);
			// } else {
			// 	_l.json = '';
			// }
			// console.log('e');
			completeArray.push(_l);

			// console.log('f');
			if (Reflect.isFunction(_l.func))
				Reflect.callMethod(_l.func, _l.func, [_l]);

			// console.log('g');
			if (Reflect.isFunction(_onUpdate))
				Reflect.callMethod(_onUpdate, _onUpdate, ['_img']);

			// console.log('h');
			_loadCounter++;

			// console.log('i');
			loadingHandler();
			// console.log('j');
			// var blob = new Blob([this.response]);
			// thisImg.src = window.URL.createObjectURL(blob);
		};
		xmlHTTP.onerror = function(error) {
			console.warn(error);
			if (Reflect.isFunction(_onError))
				Reflect.callMethod(_onError, _onError, [error]);
			_loadCounter++;
			loadingHandler();
		}
		xmlHTTP.onprogress = function(e:ProgressEvent) {
			if (Reflect.isFunction(_onProgress))
				Reflect.callMethod(this, _onProgress, [e.loaded, e.total, (e.loaded / e.total)]);
		};
		xmlHTTP.onloadstart = function() {
			if (_isDebug)
				console.debug('onloadstart');
			if (Reflect.isFunction(_onProgress))
				Reflect.callMethod(_onProgress, _onProgress, [0, 1, 0]);

			if (Reflect.isFunction(_onInit))
				Reflect.callMethod(_onInit, _onInit, ['init']);
		};
		xmlHTTP.onloadend = function() {
			if (_isDebug)
				console.debug('onloadend');
			// You can also remove your progress bar here, if you like.
			if (Reflect.isFunction(_onProgress))
				Reflect.callMethod(_onProgress, _onProgress, [1, 1, 1]);
		}

		xmlHTTP.send();
	}

	// ____________________________________ getter/setter ____________________________________

	function get__id():String {
		return _id;
	}

	function set__id(value:String):String {
		return _id = value;
	}

	function get__loadingArray():Array<LoaderObj> {
		return _loadingArray;
	}

	function set__loadingArray(value:Array<LoaderObj>):Array<LoaderObj> {
		return _loadingArray = value;
	}

	function get__isDebug():Bool {
		return _isDebug;
	}

	function set__isDebug(value:Bool):Bool {
		return _isDebug = value;
	}

	// ____________________________________ misc ____________________________________

	function toString() {
		return '[Loader]';
	}
}

enum FileType {
	Unknown;
	Img;
	IMG;
	Txt;
	TXT;
	Json;
	JSON;
	Gif;
	GIF;
	Png;
	PNG;
	JPEG;
	JPG;
	Xml;
	XML;
	Svg;
	SVG;
	Csv;
	CSV;
}

typedef LoaderObj = {
	@:optional var _id:Int;
	var path:String;
	var type:FileType;
	@:optional var time:TimeObj;
	@:optional var image:js.html.Image;
	@:optional var str:String;
	@:optional var data:Any;
	@:optional var filesize:FileSizeObj;
	@:optional var json:Dynamic;
	@:optional var func:Dynamic;
};

typedef FileSizeObj = {
	@:optional var _id:String;
	@:optional var bytes:Int;
	@:optional var KiB:Float;
	@:optional var MiB:Float;
	@:optional var GiB:Float;
}

typedef TimeObj = {
	@:optional var _id:String;
	@:optional var start:Date;
	@:optional var end:Date;
	@:optional var durationS:Float;
	@:optional var durationMS:Float;
}
