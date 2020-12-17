// Generated by Haxe 4.1.4
(function ($hx_exports, $global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); },$hxEnums = $hxEnums || {},$_;
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	this.r = new RegExp(r,opt.split("u").join(""));
};
EReg.__name__ = true;
EReg.prototype = {
	match: function(s) {
		if(this.r.global) {
			this.r.lastIndex = 0;
		}
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.exists = function(it,f) {
	var x = $getIterator(it);
	while(x.hasNext()) {
		var x1 = x.next();
		if(f(x1)) {
			return true;
		}
	}
	return false;
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.isFunction = function(f) {
	if(typeof(f) == "function") {
		return !(f.__name__ || f.__ename__);
	} else {
		return false;
	}
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) {
		return true;
	}
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) {
		return false;
	}
	if(f1.scope == f2.scope && f1.method == f2.method) {
		return f1.method != null;
	} else {
		return false;
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var haxe_Exception = function(message,previous,native) {
	Error.call(this,message);
	this.message = message;
	this.__previousException = previous;
	this.__nativeException = native != null ? native : this;
};
haxe_Exception.__name__ = true;
haxe_Exception.caught = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value;
	} else if(((value) instanceof Error)) {
		return new haxe_Exception(value.message,null,value);
	} else {
		return new haxe_ValueException(value,null,value);
	}
};
haxe_Exception.thrown = function(value) {
	if(((value) instanceof haxe_Exception)) {
		return value.get_native();
	} else if(((value) instanceof Error)) {
		return value;
	} else {
		var e = new haxe_ValueException(value);
		return e;
	}
};
haxe_Exception.__super__ = Error;
haxe_Exception.prototype = $extend(Error.prototype,{
	unwrap: function() {
		return this.__nativeException;
	}
	,get_native: function() {
		return this.__nativeException;
	}
});
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.__name__ = true;
haxe_Timer.delay = function(f,time_ms) {
	var t = new haxe_Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe_Timer.prototype = {
	stop: function() {
		if(this.id == null) {
			return;
		}
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
};
var haxe_ValueException = function(value,previous,native) {
	haxe_Exception.call(this,String(value),previous,native);
	this.value = value;
};
haxe_ValueException.__name__ = true;
haxe_ValueException.__super__ = haxe_Exception;
haxe_ValueException.prototype = $extend(haxe_Exception.prototype,{
	unwrap: function() {
		return this.value;
	}
});
var haxe_http_HttpBase = function(url) {
	this.url = url;
	this.headers = [];
	this.params = [];
	this.emptyOnData = $bind(this,this.onData);
};
haxe_http_HttpBase.__name__ = true;
haxe_http_HttpBase.prototype = {
	onData: function(data) {
	}
	,onBytes: function(data) {
	}
	,onError: function(msg) {
	}
	,onStatus: function(status) {
	}
	,hasOnData: function() {
		return !Reflect.compareMethods($bind(this,this.onData),this.emptyOnData);
	}
	,success: function(data) {
		this.responseBytes = data;
		this.responseAsString = null;
		if(this.hasOnData()) {
			this.onData(this.get_responseData());
		}
		this.onBytes(this.responseBytes);
	}
	,get_responseData: function() {
		if(this.responseAsString == null && this.responseBytes != null) {
			this.responseAsString = this.responseBytes.getString(0,this.responseBytes.length,haxe_io_Encoding.UTF8);
		}
		return this.responseAsString;
	}
};
var haxe_http_HttpJs = function(url) {
	this.async = true;
	this.withCredentials = false;
	haxe_http_HttpBase.call(this,url);
};
haxe_http_HttpJs.__name__ = true;
haxe_http_HttpJs.__super__ = haxe_http_HttpBase;
haxe_http_HttpJs.prototype = $extend(haxe_http_HttpBase.prototype,{
	request: function(post) {
		var _gthis = this;
		this.responseAsString = null;
		this.responseBytes = null;
		var r = this.req = js_Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if(r.readyState != 4) {
				return;
			}
			var s;
			try {
				s = r.status;
			} catch( _g ) {
				s = null;
			}
			if(s == 0 && typeof(window) != "undefined" && $global.location != null) {
				var protocol = $global.location.protocol.toLowerCase();
				var rlocalProtocol = new EReg("^(?:about|app|app-storage|.+-extension|file|res|widget):$","");
				var isLocal = rlocalProtocol.match(protocol);
				if(isLocal) {
					s = r.response != null ? 200 : 404;
				}
			}
			if(s == undefined) {
				s = null;
			}
			if(s != null) {
				_gthis.onStatus(s);
			}
			if(s != null && s >= 200 && s < 400) {
				_gthis.req = null;
				_gthis.success(haxe_io_Bytes.ofData(r.response));
			} else if(s == null || s == 0 && r.response == null) {
				_gthis.req = null;
				_gthis.onError("Failed to connect or resolve host");
			} else if(s == null) {
				_gthis.req = null;
				var onreadystatechange = r.response != null ? haxe_io_Bytes.ofData(r.response) : null;
				_gthis.responseBytes = onreadystatechange;
				_gthis.onError("Http Error #" + r.status);
			} else {
				switch(s) {
				case 12007:
					_gthis.req = null;
					_gthis.onError("Unknown host");
					break;
				case 12029:
					_gthis.req = null;
					_gthis.onError("Failed to connect to host");
					break;
				default:
					_gthis.req = null;
					var onreadystatechange = r.response != null ? haxe_io_Bytes.ofData(r.response) : null;
					_gthis.responseBytes = onreadystatechange;
					_gthis.onError("Http Error #" + r.status);
				}
			}
		};
		if(this.async) {
			r.onreadystatechange = onreadystatechange;
		}
		var uri;
		var _g = this.postBytes;
		var _g1 = this.postData;
		if(_g1 == null) {
			if(_g == null) {
				uri = null;
			} else {
				var bytes = _g;
				uri = new Blob([bytes.b.bufferValue]);
			}
		} else if(_g == null) {
			var str = _g1;
			uri = str;
		} else {
			uri = null;
		}
		if(uri != null) {
			post = true;
		} else {
			var _g = 0;
			var _g1 = this.params;
			while(_g < _g1.length) {
				var p = _g1[_g];
				++_g;
				if(uri == null) {
					uri = "";
				} else {
					uri = (uri == null ? "null" : Std.string(uri)) + "&";
				}
				var s = p.name;
				var value = (uri == null ? "null" : Std.string(uri)) + encodeURIComponent(s) + "=";
				var s1 = p.value;
				uri = value + encodeURIComponent(s1);
			}
		}
		try {
			if(post) {
				r.open("POST",this.url,this.async);
			} else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question ? "?" : "&") + (uri == null ? "null" : Std.string(uri)),this.async);
				uri = null;
			} else {
				r.open("GET",this.url,this.async);
			}
			r.responseType = "arraybuffer";
		} catch( _g ) {
			var e = haxe_Exception.caught(_g).unwrap();
			this.req = null;
			this.onError(e.toString());
			return;
		}
		r.withCredentials = this.withCredentials;
		if(!Lambda.exists(this.headers,function(h) {
			return h.name == "Content-Type";
		}) && post && this.postData == null) {
			r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		}
		var _g = 0;
		var _g1 = this.headers;
		while(_g < _g1.length) {
			var h = _g1[_g];
			++_g;
			r.setRequestHeader(h.name,h.value);
		}
		r.send(uri);
		if(!this.async) {
			onreadystatechange(null);
		}
	}
});
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
haxe_io_Bytes.__name__ = true;
haxe_io_Bytes.ofData = function(b) {
	var hb = b.hxBytes;
	if(hb != null) {
		return hb;
	}
	return new haxe_io_Bytes(b);
};
haxe_io_Bytes.prototype = {
	getString: function(pos,len,encoding) {
		if(pos < 0 || len < 0 || pos + len > this.length) {
			throw haxe_Exception.thrown(haxe_io_Error.OutsideBounds);
		}
		if(encoding == null) {
			encoding = haxe_io_Encoding.UTF8;
		}
		var s = "";
		var b = this.b;
		var i = pos;
		var max = pos + len;
		switch(encoding._hx_index) {
		case 0:
			var debug = pos > 0;
			while(i < max) {
				var c = b[i++];
				if(c < 128) {
					if(c == 0) {
						break;
					}
					s += String.fromCodePoint(c);
				} else if(c < 224) {
					var code = (c & 63) << 6 | b[i++] & 127;
					s += String.fromCodePoint(code);
				} else if(c < 240) {
					var c2 = b[i++];
					var code1 = (c & 31) << 12 | (c2 & 127) << 6 | b[i++] & 127;
					s += String.fromCodePoint(code1);
				} else {
					var c21 = b[i++];
					var c3 = b[i++];
					var u = (c & 15) << 18 | (c21 & 127) << 12 | (c3 & 127) << 6 | b[i++] & 127;
					s += String.fromCodePoint(u);
				}
			}
			break;
		case 1:
			while(i < max) {
				var c = b[i++] | b[i++] << 8;
				s += String.fromCodePoint(c);
			}
			break;
		}
		return s;
	}
};
var haxe_io_Encoding = $hxEnums["haxe.io.Encoding"] = { __ename__ : true, __constructs__ : ["UTF8","RawNative"]
	,UTF8: {_hx_index:0,__enum__:"haxe.io.Encoding",toString:$estr}
	,RawNative: {_hx_index:1,__enum__:"haxe.io.Encoding",toString:$estr}
};
var haxe_io_Error = $hxEnums["haxe.io.Error"] = { __ename__ : true, __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"]
	,Blocked: {_hx_index:0,__enum__:"haxe.io.Error",toString:$estr}
	,Overflow: {_hx_index:1,__enum__:"haxe.io.Error",toString:$estr}
	,OutsideBounds: {_hx_index:2,__enum__:"haxe.io.Error",toString:$estr}
	,Custom: ($_=function(e) { return {_hx_index:3,e:e,__enum__:"haxe.io.Error",toString:$estr}; },$_.__params__ = ["e"],$_)
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o.__enum__) {
			var e = $hxEnums[o.__enum__];
			var n = e.__constructs__[o._hx_index];
			var con = e[n];
			if(con.__params__) {
				s = s + "\t";
				return n + "(" + ((function($this) {
					var $r;
					var _g = [];
					{
						var _g1 = 0;
						var _g2 = con.__params__;
						while(true) {
							if(!(_g1 < _g2.length)) {
								break;
							}
							var p = _g2[_g1];
							_g1 = _g1 + 1;
							_g.push(js_Boot.__string_rec(o[p],s));
						}
					}
					$r = _g;
					return $r;
				}(this))).join(",") + ")";
			} else {
				return n;
			}
		}
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_Browser = function() { };
js_Browser.__name__ = true;
js_Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") {
		return new XMLHttpRequest();
	}
	if(typeof ActiveXObject != "undefined") {
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	throw haxe_Exception.thrown("Unable to create XMLHttpRequest object.");
};
var Loader = $hx_exports["Loader"] = function(id) {
	this._loadCounter = 0;
	this._isDebug = false;
	this.completeArray = [];
	this._loadingArray = [];
	if(id == null) {
		this.set__id("" + this.toString() + "_" + new Date().getTime());
	} else {
		this.set__id(id);
	}
};
Loader.__name__ = true;
Loader.create = function(id) {
	var loader = new Loader(id);
	return loader;
};
Loader.prototype = {
	isDebug: function(isDebug) {
		if(isDebug == null) {
			isDebug = true;
		}
		this.set__isDebug(isDebug);
		return this;
	}
	,add: function(path,func,type) {
		var _type = type == null ? this.fileType(path) : type;
		var _obj = { _id : path, path : path, type : _type, time : { }, filesize : { }, func : func};
		if(this.get__isDebug()) {
			$global.console.debug(_obj);
		}
		this.get__loadingArray().push(_obj);
		return this;
	}
	,load: function() {
		if(this.get__isDebug()) {
			$global.console.debug("init loading");
		}
		this.loadingHandler();
		return this;
	}
	,onComplete: function(func,arr) {
		this._onComplete = func;
		this._onCompleteParams = arr;
		return this;
	}
	,onUpdate: function(func,arr) {
		this._onUpdate = func;
		this._onUpdateParams = arr;
		return this;
	}
	,onProgress: function(func,arr) {
		this._onProgress = func;
		this._onProgressParams = arr;
		return this;
	}
	,onError: function(func,arr) {
		this._onError = func;
		this._onErrorParams = arr;
		return this;
	}
	,onInit: function(func,arr) {
		this._onInit = func;
		this._onInitParams = arr;
		return this;
	}
	,fileType: function(path) {
		var type = sketcher_load_FileType.Unknown;
		var ext = path.split(".")[path.split(".").length - 1];
		switch(ext.toLowerCase()) {
		case "csv":
			type = sketcher_load_FileType.Csv;
			break;
		case "gif":
			type = sketcher_load_FileType.Gif;
			break;
		case "jpeg":case "jpg":
			type = sketcher_load_FileType.JPG;
			break;
		case "json":
			type = sketcher_load_FileType.Json;
			break;
		case "png":
			type = sketcher_load_FileType.Png;
			break;
		case "svg":
			type = sketcher_load_FileType.Svg;
			break;
		case "txt":
			type = sketcher_load_FileType.Txt;
			break;
		case "xml":
			type = sketcher_load_FileType.Xml;
			break;
		default:
			type = sketcher_load_FileType.Unknown;
		}
		if(this.get__isDebug()) {
			$global.console.log(ext);
		}
		return type;
	}
	,loadingHandler: function() {
		var _gthis = this;
		if(this._loadCounter >= this.get__loadingArray().length) {
			if(this.get__isDebug()) {
				$global.console.debug("" + this.toString() + " :: Loading queue is done");
			}
			if(this.get__isDebug()) {
				$global.console.debug("show completed array: " + Std.string(this.completeArray));
			}
			if(this.get__isDebug()) {
				$global.console.debug("length of complete files: " + this.completeArray.length);
			}
			if(Reflect.isFunction(this._onComplete)) {
				haxe_Timer.delay(function() {
					_gthis._onComplete.apply(_gthis._onComplete,[_gthis.completeArray]);
				},1);
			}
			return;
		}
		var _l = this.get__loadingArray()[this._loadCounter];
		switch(_l.type._hx_index) {
		case 3:case 13:case 15:case 17:
			this.textLoader(_l);
			break;
		case 5:
			this.textLoaderBig(_l);
			break;
		case 1:case 7:case 9:case 11:case 12:
			this.imageLoader(_l);
			break;
		default:
			$global.console.warn("not sure what this type is?: \"" + _l.path + "\"");
		}
	}
	,imageLoader: function(_l) {
		var _gthis = this;
		_l.time.start = new Date();
		var _img = new Image();
		_img.crossOrigin = "Anonymous";
		_img.src = _l.path;
		_img.onload = function() {
			_l.time.end = new Date();
			_l.time.durationMS = _l.time.end.getTime() - _l.time.start.getTime();
			_l.time.durationS = (_l.time.end.getTime() - _l.time.start.getTime()) / 1000;
			if(_gthis.get__isDebug()) {
				console.log("src/sketcher/load/Loader.hx:278:","image source: " + _img.src);
				console.log("src/sketcher/load/Loader.hx:279:","image width: " + _img.width);
				console.log("src/sketcher/load/Loader.hx:280:","image height: " + _img.height);
			}
			if(_gthis.get__isDebug()) {
				console.log("src/sketcher/load/Loader.hx:284:","complete array length: " + _gthis.completeArray.length);
			}
			_l.image = _img;
			_gthis.completeArray.push(_l);
			if(_gthis.get__isDebug()) {
				console.log("src/sketcher/load/Loader.hx:288:","complete array: " + Std.string(_gthis.completeArray));
			}
			if(_gthis.get__isDebug()) {
				console.log("src/sketcher/load/Loader.hx:290:","complete array length: " + _gthis.completeArray.length);
			}
			if(Reflect.isFunction(_l.func)) {
				_l.func.apply(_l.func,[_l]);
			}
			if(Reflect.isFunction(_gthis._onUpdate)) {
				_gthis._onUpdate.apply(_gthis._onUpdate,[_img]);
			}
			_gthis._loadCounter++;
			_gthis.loadingHandler();
		};
		_img.onerror = function() {
			if(Reflect.isFunction(_gthis._onError)) {
				_gthis._onError.apply(_gthis._onError,[_img]);
			}
			_gthis._loadCounter++;
			_gthis.loadingHandler();
		};
		_img.onprogress = function() {
			if(Reflect.isFunction(_gthis._onProgress)) {
				_gthis._onProgress.apply(_gthis._onProgress,[_img]);
			}
		};
	}
	,textLoader: function(_l) {
		var _gthis = this;
		var url = _l.path;
		_l.time.start = new Date();
		var req = new haxe_http_HttpJs(url);
		req.onData = function(data) {
			_l.filesize.bytes = req.responseBytes.length;
			_l.filesize.KiB = req.responseBytes.length / 1024;
			_l.filesize.MiB = req.responseBytes.length / 1024 / 1024;
			_l.filesize.GiB = req.responseBytes.length / 1024 / 1024 / 1024;
			try {
				_l.str = data;
				_l.time.end = new Date();
				_l.time.durationMS = _l.time.end.getTime() - _l.time.start.getTime();
				_l.time.durationS = (_l.time.end.getTime() - _l.time.start.getTime()) / 1000;
				if(_l.type == sketcher_load_FileType.Json) {
					_l.json = JSON.parse(data);
				} else {
					_l.json = "";
				}
				_gthis.completeArray.push(_l);
				if(Reflect.isFunction(_l.func)) {
					_l.func.apply(_l.func,[_l]);
				}
				if(Reflect.isFunction(_gthis._onUpdate)) {
					_gthis._onUpdate.apply(_gthis._onUpdate,["_img"]);
				}
				_gthis._loadCounter++;
				_gthis.loadingHandler();
			} catch( _g ) {
				var e = haxe_Exception.caught(_g).unwrap();
				if(_gthis.get__isDebug()) {
					console.log("src/sketcher/load/Loader.hx:356:",e);
				}
				if(Reflect.isFunction(_gthis._onError)) {
					_gthis._onError.apply(_gthis._onError,[e]);
				}
				_gthis._loadCounter++;
				_gthis.loadingHandler();
			}
		};
		req.onError = function(error) {
			if(_gthis.get__isDebug()) {
				$global.console.error("error: " + error + ", " + url);
			}
			if(Reflect.isFunction(_gthis._onError)) {
				_gthis._onError.apply(_gthis._onError,[error]);
			}
			_gthis._loadCounter++;
			_gthis.loadingHandler();
		};
		req.onStatus = function(status) {
			if(_gthis.get__isDebug()) {
				$global.console.debug("status: " + status);
			}
		};
		req.request(false);
		if(Reflect.isFunction(this._onInit)) {
			this._onInit.apply(this._onInit,["start loading file"]);
		}
	}
	,textLoaderBig: function(_l) {
		var _gthis = this;
		if(this.get__isDebug()) {
			$global.console.info("[" + Std.string(_l.type) + "] loader: " + _l.path);
		}
		var url = _l.path;
		_l.time.start = new Date();
		var xmlHTTP = new XMLHttpRequest();
		xmlHTTP.open("GET",url,true);
		xmlHTTP.onreadystatechange = function(e) {
			if(xmlHTTP.readyState == 4) {
				if(xmlHTTP.status == 404) {
					$global.console.warn("looks like the file doesn't exist at path: " + _l.path);
				}
			}
		};
		xmlHTTP.ontimeout = function(e) {
			$global.console.log(e);
		};
		switch(_l.type._hx_index) {
		case 5:case 6:
			xmlHTTP.responseType = "json";
			break;
		case 15:
			xmlHTTP.responseType = "text";
			break;
		default:
			xmlHTTP.responseType = "text";
			$global.console.warn("case '" + Std.string(_l.type) + "': trace ('" + Std.string(_l.type) + "');");
		}
		xmlHTTP.onload = function(e) {
			var data = xmlHTTP.response;
			if(_gthis.get__isDebug()) {
				$global.console.log(e);
			}
			_l.filesize.bytes = e.total;
			_l.filesize.KiB = e.total / 1024;
			_l.filesize.MiB = e.total / 1024 / 1024;
			_l.filesize.GiB = e.total / 1024 / 1024 / 1024;
			_l.str = data;
			_l.data = data;
			_l.time.end = new Date();
			_l.time.durationMS = _l.time.end.getTime() - _l.time.start.getTime();
			_l.time.durationS = (_l.time.end.getTime() - _l.time.start.getTime()) / 1000;
			_gthis.completeArray.push(_l);
			if(Reflect.isFunction(_l.func)) {
				_l.func.apply(_l.func,[_l]);
			}
			if(Reflect.isFunction(_gthis._onUpdate)) {
				_gthis._onUpdate.apply(_gthis._onUpdate,["_img"]);
			}
			_gthis._loadCounter++;
			_gthis.loadingHandler();
		};
		xmlHTTP.onerror = function(error) {
			$global.console.warn(error);
			if(Reflect.isFunction(_gthis._onError)) {
				_gthis._onError.apply(_gthis._onError,[error]);
			}
			_gthis._loadCounter++;
			_gthis.loadingHandler();
		};
		xmlHTTP.onprogress = function(e) {
			if(Reflect.isFunction(_gthis._onProgress)) {
				_gthis._onProgress.apply(_gthis,[e.loaded,e.total,e.loaded / e.total]);
			}
		};
		xmlHTTP.onloadstart = function() {
			if(_gthis.get__isDebug()) {
				$global.console.debug("[" + Std.string(_l.type) + "] onloadstart");
			}
			if(Reflect.isFunction(_gthis._onProgress)) {
				_gthis._onProgress.apply(_gthis._onProgress,[0,1,0]);
			}
			if(Reflect.isFunction(_gthis._onInit)) {
				_gthis._onInit.apply(_gthis._onInit,["init"]);
			}
		};
		xmlHTTP.onloadend = function() {
			if(_gthis.get__isDebug()) {
				$global.console.debug("[" + Std.string(_l.type) + "] onloadend");
			}
			if(Reflect.isFunction(_gthis._onProgress)) {
				_gthis._onProgress.apply(_gthis._onProgress,[1,1,1]);
			}
		};
		xmlHTTP.send();
	}
	,get__id: function() {
		return this._id;
	}
	,set__id: function(value) {
		return this._id = value;
	}
	,get__loadingArray: function() {
		return this._loadingArray;
	}
	,set__loadingArray: function(value) {
		return this._loadingArray = value;
	}
	,get__isDebug: function() {
		return this._isDebug;
	}
	,set__isDebug: function(value) {
		return this._isDebug = value;
	}
	,toString: function() {
		return "[Loader]";
	}
};
var sketcher_load_FileType = $hxEnums["sketcher.load.FileType"] = { __ename__ : true, __constructs__ : ["Unknown","Img","IMG","Txt","TXT","Json","JSON","Gif","GIF","Png","PNG","JPEG","JPG","Xml","XML","Svg","SVG","Csv","CSV"]
	,Unknown: {_hx_index:0,__enum__:"sketcher.load.FileType",toString:$estr}
	,Img: {_hx_index:1,__enum__:"sketcher.load.FileType",toString:$estr}
	,IMG: {_hx_index:2,__enum__:"sketcher.load.FileType",toString:$estr}
	,Txt: {_hx_index:3,__enum__:"sketcher.load.FileType",toString:$estr}
	,TXT: {_hx_index:4,__enum__:"sketcher.load.FileType",toString:$estr}
	,Json: {_hx_index:5,__enum__:"sketcher.load.FileType",toString:$estr}
	,JSON: {_hx_index:6,__enum__:"sketcher.load.FileType",toString:$estr}
	,Gif: {_hx_index:7,__enum__:"sketcher.load.FileType",toString:$estr}
	,GIF: {_hx_index:8,__enum__:"sketcher.load.FileType",toString:$estr}
	,Png: {_hx_index:9,__enum__:"sketcher.load.FileType",toString:$estr}
	,PNG: {_hx_index:10,__enum__:"sketcher.load.FileType",toString:$estr}
	,JPEG: {_hx_index:11,__enum__:"sketcher.load.FileType",toString:$estr}
	,JPG: {_hx_index:12,__enum__:"sketcher.load.FileType",toString:$estr}
	,Xml: {_hx_index:13,__enum__:"sketcher.load.FileType",toString:$estr}
	,XML: {_hx_index:14,__enum__:"sketcher.load.FileType",toString:$estr}
	,Svg: {_hx_index:15,__enum__:"sketcher.load.FileType",toString:$estr}
	,SVG: {_hx_index:16,__enum__:"sketcher.load.FileType",toString:$estr}
	,Csv: {_hx_index:17,__enum__:"sketcher.load.FileType",toString:$estr}
	,CSV: {_hx_index:18,__enum__:"sketcher.load.FileType",toString:$estr}
};
function $getIterator(o) { if( o instanceof Array ) return new haxe_iterators_ArrayIterator(o); else return o.iterator(); }
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
if( String.fromCodePoint == null ) String.fromCodePoint = function(c) { return c < 0x10000 ? String.fromCharCode(c) : String.fromCharCode((c>>10)+0xD7C0)+String.fromCharCode((c&0x3FF)+0xDC00); }
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
js_Boot.__toStr = ({ }).toString;
})(typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);