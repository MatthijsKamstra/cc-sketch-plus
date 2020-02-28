// Generated by Haxe 4.0.3
(function ($global) { "use strict";
function $extend(from, fields) {
	var proto = Object.create(from);
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var MainWebgl = function() {
	var _gthis = this;
	window.document.addEventListener("DOMContentLoaded",function(event) {
		console.log("src/MainWebgl.hx:28:","MainWebgl");
		window.console.log("" + sketcher_App.NAME + " Dom ready :: build: " + "2020-02-28 12:00:59");
		_gthis.setupDocument();
		_gthis.setupCanvas();
		_gthis.setupGL();
	});
};
MainWebgl.__name__ = true;
MainWebgl.main = function() {
	var app = new MainWebgl();
};
MainWebgl.prototype = {
	setupGL: function() {
	}
	,setupDocument: function() {
		sketcher_util_EmbedUtil.bootstrapStyle();
		sketcher_util_EmbedUtil.datgui();
		var style = "body{background-color:silver} canvas{border:1px solid gray;background-color:white; background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAFUlEQVQImWNgQAMXL178T3UBBgYGAIeiETu3apCOAAAAAElFTkSuQmCC)}}";
		new html_CSSinjector(style);
	}
	,setupCanvas: function() {
		var webgl = new sketcher_webgl_WebGl(500,200);
		var gl = webgl.gl;
		gl.viewport(0,0,webgl.canvas.width,webgl.canvas.height);
		gl.clearColor(0,0.5,0,1);
		gl.clear(16384);
		var vs = " attribute vec2 aVertexPosition;\n\t\tvoid main() {\n\t\t\tgl_Position = vec4(aVertexPosition, 0.0, 1.0);\n\t\t}";
		var fs = "uniform vec4 uColor;\n\t\tvoid main() {\n\t\t\tgl_FragColor = uColor;\n\t\t}";
		webgl.setupProgram(vs,fs);
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
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
var haxe_io_Bytes = function() { };
haxe_io_Bytes.__name__ = true;
var html_CSSinjector = function(styles,elementID) {
	if(elementID == null) {
		elementID = "inject-" + new Date().getTime();
	}
	if(styles != null) {
		this.setCSS(styles,elementID);
	}
};
html_CSSinjector.__name__ = true;
html_CSSinjector.prototype = {
	setCSS: function(styles,elementID) {
		styles = this.minify(styles);
		var css = window.document.createElement("style");
		css.id = elementID;
		css.type = "text/css";
		if(css.styleSheet) {
			css.styleSheet.cssText = styles;
		} else {
			css.appendChild(window.document.createTextNode(styles));
		}
		window.document.getElementsByTagName("head")[0].appendChild(css);
	}
	,minify: function(css) {
		return css;
	}
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
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
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g3 = 0;
			var _g11 = o.length;
			while(_g3 < _g11) {
				var i = _g3++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e1 ) {
			var e2 = ((e1) instanceof js__$Boot_HaxeError) ? e1.val : e1;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str1 = "{\n";
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
		if(str1.length != 2) {
			str1 += ", \n";
		}
		str1 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str1 += "\n" + s + "}";
		return str1;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var js_html__$CanvasElement_CanvasUtil = function() { };
js_html__$CanvasElement_CanvasUtil.__name__ = true;
js_html__$CanvasElement_CanvasUtil.getContextWebGL = function(canvas,attribs) {
	var name = "webgl";
	var ctx = canvas.getContext(name,attribs);
	if(ctx != null) {
		return ctx;
	}
	var name1 = "experimental-webgl";
	var ctx1 = canvas.getContext(name1,attribs);
	if(ctx1 != null) {
		return ctx1;
	}
	return null;
};
var sketcher_App = function() { };
sketcher_App.__name__ = true;
var sketcher_util_EmbedUtil = function() {
};
sketcher_util_EmbedUtil.__name__ = true;
sketcher_util_EmbedUtil.check = function(id) {
	if(window.document.getElementById(id) != null) {
		return true;
	} else {
		return false;
	}
};
sketcher_util_EmbedUtil.stats = function() {
	var script = document.createElement('script');script.onload = function() {var stats = new Stats();document.body.appendChild(stats.dom);requestAnimationFrame(function loop() {stats.update();requestAnimationFrame(loop)});};script.src = '//mrdoob.github.io/stats.js/build/stats.min.js';document.head.appendChild(script);
};
sketcher_util_EmbedUtil.script = function(id,src,callback,callbackArray) {
	var el = window.document.createElement("script");
	el.id = id;
	el.src = src;
	el.crossOrigin = "anonymous";
	el.onload = function() {
		if(callback != null) {
			if(callbackArray == null) {
				callback.apply(callback,[id]);
			} else {
				callback.apply(callback,callbackArray);
			}
		}
	};
	window.document.body.appendChild(el);
};
sketcher_util_EmbedUtil.stylesheet = function(id,src,callback,callbackArray) {
	var el = window.document.createElement("link");
	el.id = id;
	el.rel = "stylesheet";
	el.href = src;
	el.onload = function() {
		if(callback != null) {
			if(callbackArray == null) {
				callback.apply(callback,["id"]);
			} else {
				callback.apply(callback,callbackArray);
			}
		}
	};
	window.document.head.appendChild(el);
};
sketcher_util_EmbedUtil.bootstrapStylesheet = function(id,src,integrity,callback,callbackArray) {
	var el = window.document.createElement("link");
	el.id = id;
	el.rel = "stylesheet";
	el.href = src;
	el.integrity = integrity;
	el.crossOrigin = "anonymous";
	el.onload = function() {
		if(callback != null) {
			if(callbackArray == null) {
				callback.apply(callback,[id]);
			} else {
				callback.apply(callback,callbackArray);
			}
		}
	};
	window.document.head.appendChild(el);
};
sketcher_util_EmbedUtil.bootstrapScript = function(id,src,integrity,callback,callbackArray) {
	var el = window.document.createElement("script");
	el.id = id;
	el.src = src;
	el.integrity = integrity;
	el.crossOrigin = "anonymous";
	el.onload = function() {
		if(callback != null) {
			if(callbackArray == null) {
				callback.apply(callback,[id]);
			} else {
				callback.apply(callback,callbackArray);
			}
		}
	};
	window.document.body.appendChild(el);
};
sketcher_util_EmbedUtil.quicksettings = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.script("quicksettings","https://cdn.jsdelivr.net/quicksettings/3.0.2/quicksettings.min.js",callback,callbackArray);
};
sketcher_util_EmbedUtil.gsap = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.script("gsap","https://cdnjs.cloudflare.com/ajax/libs/gsap/3.2.0/gsap.min.js",callback,callbackArray);
};
sketcher_util_EmbedUtil.ccnav = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.script("ccnav","https://matthijskamstra.github.io/drop-in-off-canvas-menu/cc_nav.min.js",callback,callbackArray);
};
sketcher_util_EmbedUtil.datgui = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.script("datgui","https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.7.6/dat.gui.min.js",callback,callbackArray);
	var style = window.document.createElement("style");
	style.innerHTML = ".dg .c input[type=\"text\"]{\n\t\t\tline-height : normal;\n\t\t}";
	window.document.head.appendChild(style);
};
sketcher_util_EmbedUtil.sanitize = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.stylesheet("sanitize","https://cdnjs.cloudflare.com/ajax/libs/10up-sanitize.css/8.0.0/sanitize.css",callback,callbackArray);
};
sketcher_util_EmbedUtil.ficons = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.stylesheet("ficons","https://cdn.jsdelivr.net/npm/ficons@1.1.52/dist/ficons/font.css",callback,callbackArray);
};
sketcher_util_EmbedUtil.bootstrap = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.bootstrapStylesheet("bootstrap-stylesheet","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css","sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh");
	sketcher_util_EmbedUtil.bootstrapScript("bootstrap-jquery","https://code.jquery.com/jquery-3.4.1.slim.min.js","sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n");
	sketcher_util_EmbedUtil.bootstrapScript("bootstrap-popper","https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js","sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo");
	sketcher_util_EmbedUtil.bootstrapScript("bootstrap-bootstrap","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js","sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6");
};
sketcher_util_EmbedUtil.bootstrapStyle = function(callback,callbackArray) {
	sketcher_util_EmbedUtil.bootstrapStylesheet("bootstrap-stylesheet","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css","sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh",callback,callbackArray);
};
sketcher_util_EmbedUtil.zip = function(callback,callbackArray) {
	if(!sketcher_util_EmbedUtil.check("jszip")) {
		sketcher_util_EmbedUtil.script("jszip","https://cdnjs.cloudflare.com/ajax/libs/jszip/3.2.0/jszip.min.js",callback,["jszip"]);
	}
	if(!sketcher_util_EmbedUtil.check("jsfilesaver")) {
		sketcher_util_EmbedUtil.script("jsfilesaver","https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js",callback,["jsfilesaver"]);
	}
};
sketcher_util_EmbedUtil.embedGoogleFont = function(family,callback,callbackArray) {
	window.console.info("embedGoogleFont " + family);
	var _family = sketcher_util_EmbedUtil.cleanFontFamily(family);
	var _id = "embededGoogleFonts";
	var _url = "https://fonts.googleapis.com/css?family=";
	var _display = "&display=swap";
	var link = window.document.getElementById(_id);
	if(link != null) {
		var temp = StringTools.replace(StringTools.replace(link.href,_url,""),_display,"");
		family = temp + "|" + family;
	} else {
		link = window.document.createElement("link");
	}
	if(callbackArray == null) {
		callbackArray = [family];
	}
	link.href = "" + _url + family + _display;
	link.rel = "stylesheet";
	link.id = _id;
	link.onload = function() {
		if(callback != null) {
			haxe_Timer.delay(function() {
				callback.apply(callback,callbackArray);
				return;
			},1);
		}
	};
	window.document.head.appendChild(link);
	window.console.info("embedGoogleFont " + family);
	return _family;
};
sketcher_util_EmbedUtil.cleanFontFamily = function(family) {
	if(family.indexOf(":") != -1) {
		family = family.split(":")[0];
	}
	return StringTools.replace(family,"+"," ");
};
sketcher_util_EmbedUtil.fontMono = function(callback,callbackArray) {
	var fontFamily = "Source+Code+Pro";
	return sketcher_util_EmbedUtil.embedGoogleFont(fontFamily,callback,callbackArray);
};
sketcher_util_EmbedUtil.fontHandwritten = function(callback,callbackArray) {
	var fontFamily = "Pacifico";
	return sketcher_util_EmbedUtil.embedGoogleFont(fontFamily,callback,callbackArray);
};
sketcher_util_EmbedUtil.fontDisplay = function(callback,callbackArray) {
	var fontFamily = "Bebas+Neue";
	return sketcher_util_EmbedUtil.embedGoogleFont(fontFamily,callback,callbackArray);
};
var sketcher_webgl_WebGLSetup = function(width_,height_,autoChild) {
	if(autoChild == null) {
		autoChild = true;
	}
	var this1 = new Float32Array(100);
	this.colors = this1;
	var this11 = new Uint16Array(100);
	this.indices = this11;
	var this12 = new Float32Array(100);
	this.vertices = this12;
	this.BACK = true;
	this.CULL_FACE = true;
	this.DEPTH_TEST = true;
	this.bgAlpha = 1.;
	this.bgBlue = 1.;
	this.bgGreen = 1.;
	this.bgRed = 1.;
	var this13 = new Float32Array(16);
	var arr = this13;
	arr[0] = 1.0;
	arr[1] = 0.0;
	arr[2] = 0.0;
	arr[3] = 0.0;
	arr[4] = 1.0;
	arr[5] = 0.0;
	arr[6] = 0.0;
	arr[7] = 0.0;
	arr[8] = 1.0;
	arr[9] = 0.0;
	arr[10] = 0.0;
	arr[11] = 0.0;
	arr[12] = 1.0;
	arr[13] = 0.0;
	arr[14] = 0.0;
	arr[15] = 0.0;
	this.matrix32Array = arr;
	this.setupCanvas(width_,height_,autoChild);
};
sketcher_webgl_WebGLSetup.__name__ = true;
sketcher_webgl_WebGLSetup.passIndicesToShader = function(gl,indices) {
	var indexBuffer = gl.createBuffer();
	gl.bindBuffer(34963,indexBuffer);
	gl.bufferData(34963,indices,35044);
	gl.bindBuffer(34963,null);
};
sketcher_webgl_WebGLSetup.shaderFromString = function(gl,shaderType,shaderString) {
	var shader = gl.createShader(shaderType);
	gl.shaderSource(shader,shaderString);
	gl.compileShader(shader);
	return shader;
};
sketcher_webgl_WebGLSetup.createShaderProgram = function(gl,vertex,fragment) {
	var program = gl.createProgram();
	gl.attachShader(program,vertex);
	gl.attachShader(program,fragment);
	gl.linkProgram(program);
	gl.useProgram(program);
	return program;
};
sketcher_webgl_WebGLSetup.shaderInput = function(gl,program,name,att,arr,number) {
	var buffer = gl.createBuffer();
	var arrBuffer = 34962;
	gl.bindBuffer(arrBuffer,buffer);
	gl.bufferData(arrBuffer,arr,35044);
	var flo = gl.getAttribLocation(program,name);
	gl.vertexAttribPointer(flo,att,number,false,0,0);
	gl.enableVertexAttribArray(flo);
	gl.bindBuffer(arrBuffer,null);
};
sketcher_webgl_WebGLSetup.uploadDataToBuffers = function(gl,program,vertices,colors,texture) {
	var name = sketcher_webgl_WebGLSetup.posName;
	var buffer = gl.createBuffer();
	var arrBuffer = 34962;
	gl.bindBuffer(arrBuffer,buffer);
	gl.bufferData(arrBuffer,vertices,35044);
	var flo = gl.getAttribLocation(program,name);
	gl.vertexAttribPointer(flo,3,5126,false,0,0);
	gl.enableVertexAttribArray(flo);
	gl.bindBuffer(arrBuffer,null);
	var name1 = sketcher_webgl_WebGLSetup.colorName;
	var buffer1 = gl.createBuffer();
	var arrBuffer1 = 34962;
	gl.bindBuffer(arrBuffer1,buffer1);
	gl.bufferData(arrBuffer1,colors,35044);
	var flo1 = gl.getAttribLocation(program,name1);
	gl.vertexAttribPointer(flo1,4,5126,false,0,0);
	gl.enableVertexAttribArray(flo1);
	gl.bindBuffer(arrBuffer1,null);
	if(texture != null) {
		var name2 = sketcher_webgl_WebGLSetup.textureName;
		var buffer2 = gl.createBuffer();
		var arrBuffer2 = 34962;
		gl.bindBuffer(arrBuffer2,buffer2);
		gl.bufferData(arrBuffer2,texture,35044);
		var flo2 = gl.getAttribLocation(program,name2);
		gl.vertexAttribPointer(flo2,2,5126,false,0,0);
		gl.enableVertexAttribArray(flo2);
		gl.bindBuffer(arrBuffer2,null);
	}
};
sketcher_webgl_WebGLSetup.uploadImage = function(gl,image) {
	var texture = gl.createTexture();
	gl.activeTexture(33984);
	gl.bindTexture(3553,texture);
	gl.pixelStorei(37440,1);
	gl.texParameteri(3553,10242,33071);
	gl.texParameteri(3553,10243,33071);
	gl.texParameteri(3553,10241,9728);
	gl.texParameteri(3553,10240,9728);
	gl.texImage2D(3553,0,6408,6408,5121,image);
};
sketcher_webgl_WebGLSetup.toRGB = function(int) {
	return { r : (int >> 16 & 255) / 255, g : (int >> 8 & 255) / 255, b : (int & 255) / 255};
};
sketcher_webgl_WebGLSetup.ident = function() {
	var this1 = new Float32Array(16);
	var arr = this1;
	arr[0] = 1.0;
	arr[1] = 0.0;
	arr[2] = 0.0;
	arr[3] = 0.0;
	arr[4] = 1.0;
	arr[5] = 0.0;
	arr[6] = 0.0;
	arr[7] = 0.0;
	arr[8] = 1.0;
	arr[9] = 0.0;
	arr[10] = 0.0;
	arr[11] = 0.0;
	arr[12] = 1.0;
	arr[13] = 0.0;
	arr[14] = 0.0;
	arr[15] = 0.0;
	return arr;
};
sketcher_webgl_WebGLSetup.prototype = {
	setupCanvas: function(width_,height_,autoChild) {
		if(autoChild == null) {
			autoChild = true;
		}
		this.width = width_;
		this.height = height_;
		this.canvas = window.document.createElement("canvas");
		this.canvas.width = this.width;
		this.canvas.height = this.height;
		var dom = this.canvas;
		var style = dom.style;
		style.paddingLeft = "0px";
		style.paddingTop = "0px";
		style.left = Std.string(0 + "px");
		style.top = Std.string(0 + "px");
		style.position = "absolute";
		if(autoChild) {
			window.document.body.appendChild(this.canvas);
		}
		this.gl = js_html__$CanvasElement_CanvasUtil.getContextWebGL(this.canvas,null);
	}
	,setupProgram: function(vertexString,fragmentString) {
		var gl = this.gl;
		var shader = gl.createShader(35633);
		gl.shaderSource(shader,vertexString);
		gl.compileShader(shader);
		var vertex = shader;
		var gl1 = this.gl;
		var shader1 = gl1.createShader(35632);
		gl1.shaderSource(shader1,fragmentString);
		gl1.compileShader(shader1);
		var fragment = shader1;
		var gl2 = this.gl;
		var program = gl2.createProgram();
		gl2.attachShader(program,vertex);
		gl2.attachShader(program,fragment);
		gl2.linkProgram(program);
		gl2.useProgram(program);
		this.program = program;
		return this.program;
	}
	,addImage: function(img) {
		var gl = this.gl;
		var texture = gl.createTexture();
		gl.activeTexture(33984);
		gl.bindTexture(3553,texture);
		gl.pixelStorei(37440,1);
		gl.texParameteri(3553,10242,33071);
		gl.texParameteri(3553,10243,33071);
		gl.texParameteri(3553,10241,9728);
		gl.texParameteri(3553,10240,9728);
		gl.texImage2D(3553,0,6408,6408,5121,img);
	}
	,clearVerticesAndColors: function() {
		var vl = this.vertices.length;
		var il = this.indices.length;
		var cl = this.colors.length;
		var this1 = new Float32Array(vl);
		this.vertices = this1;
		var this11 = new Uint16Array(il);
		this.indices = this11;
		var this12 = new Float32Array(cl);
		this.colors = this12;
	}
	,setVerticesAndColors: function(vertices,triangleColors) {
		var rgb_r;
		var rgb_g;
		var rgb_b;
		var colorAlpha = 1.0;
		var len = this.colors.length;
		var _g = 0;
		var _g1 = vertices.length / 3 | 0;
		while(_g < _g1) {
			var i = _g++;
			var int = triangleColors[i];
			rgb_r = (int >> 16 & 255) / 255;
			rgb_g = (int >> 8 & 255) / 255;
			rgb_b = (int & 255) / 255;
			this.colors[len++] = rgb_r;
			this.colors[len++] = rgb_g;
			this.colors[len++] = rgb_b;
			this.colors[len++] = colorAlpha;
			this.colors[len++] = rgb_r;
			this.colors[len++] = rgb_g;
			this.colors[len++] = rgb_b;
			this.colors[len++] = colorAlpha;
			this.colors[len++] = rgb_r;
			this.colors[len++] = rgb_g;
			this.colors[len++] = rgb_b;
			this.colors[len++] = colorAlpha;
			this.indices[this.indices.length] = i;
		}
		var gl = this.gl;
		var indices = this.indices;
		var indexBuffer = gl.createBuffer();
		gl.bindBuffer(34963,indexBuffer);
		gl.bufferData(34963,indices,35044);
		gl.bindBuffer(34963,null);
		var gl1 = this.gl;
		var program = this.program;
		var colors = this.colors;
		var texture = null;
		var name = sketcher_webgl_WebGLSetup.posName;
		var buffer = gl1.createBuffer();
		var arrBuffer = 34962;
		gl1.bindBuffer(arrBuffer,buffer);
		gl1.bufferData(arrBuffer,vertices,35044);
		var flo = gl1.getAttribLocation(program,name);
		gl1.vertexAttribPointer(flo,3,5126,false,0,0);
		gl1.enableVertexAttribArray(flo);
		gl1.bindBuffer(arrBuffer,null);
		var name1 = sketcher_webgl_WebGLSetup.colorName;
		var buffer1 = gl1.createBuffer();
		var arrBuffer1 = 34962;
		gl1.bindBuffer(arrBuffer1,buffer1);
		gl1.bufferData(arrBuffer1,colors,35044);
		var flo1 = gl1.getAttribLocation(program,name1);
		gl1.vertexAttribPointer(flo1,4,5126,false,0,0);
		gl1.enableVertexAttribArray(flo1);
		gl1.bindBuffer(arrBuffer1,null);
		if(texture != null) {
			var name2 = sketcher_webgl_WebGLSetup.textureName;
			var buffer2 = gl1.createBuffer();
			var arrBuffer2 = 34962;
			gl1.bindBuffer(arrBuffer2,buffer2);
			gl1.bufferData(arrBuffer2,texture,35044);
			var flo2 = gl1.getAttribLocation(program,name2);
			gl1.vertexAttribPointer(flo2,2,5126,false,0,0);
			gl1.enableVertexAttribArray(flo2);
			gl1.bindBuffer(arrBuffer2,null);
		}
	}
	,render: function() {
		this.gl.clearColor(this.bgRed,this.bgGreen,this.bgBlue,this.bgAlpha);
		if(this.DEPTH_TEST) {
			this.gl.enable(2929);
		}
		if(this.CULL_FACE) {
			this.gl.enable(2884);
		}
		if(this.BACK) {
			this.gl.cullFace(1029);
		}
		this.gl.clear(16384);
		this.gl.viewport(0,0,this.canvas.width,this.canvas.height);
		var modelViewProjectionID = this.gl.getUniformLocation(this.program,"modelViewProjection");
		this.gl.uniformMatrix4fv(modelViewProjectionID,false,this.matrix32Array);
		this.gl.drawArrays(4,0,this.indices.length);
	}
};
var sketcher_webgl_WebGl = function(width,height,autoChild) {
	if(autoChild == null) {
		autoChild = true;
	}
	this.setupCanvas(width,height,autoChild);
};
sketcher_webgl_WebGl.__name__ = true;
sketcher_webgl_WebGl.shaderFromString = function(gl,shaderType,shaderString) {
	var shader = gl.createShader(shaderType);
	gl.shaderSource(shader,shaderString);
	gl.compileShader(shader);
	return shader;
};
sketcher_webgl_WebGl.resize = function(canvas) {
	var displayWidth = canvas.clientWidth;
	var displayHeight = canvas.clientHeight;
	if(canvas.width != displayWidth || canvas.height != displayHeight) {
		canvas.width = displayWidth;
		canvas.height = displayHeight;
	}
};
sketcher_webgl_WebGl.prototype = {
	setupCanvas: function(width,height,autoChild) {
		if(autoChild == null) {
			autoChild = true;
		}
		this.width = width;
		this.height = height;
		this.canvas = window.document.createElement("canvas");
		this.canvas.width = width;
		this.canvas.height = height;
		var dom = this.canvas;
		var style = dom.style;
		style.paddingLeft = "0px";
		style.paddingTop = "0px";
		style.left = Std.string(0 + "px");
		style.top = Std.string(0 + "px");
		style.position = "absolute";
		if(autoChild) {
			window.document.body.appendChild(this.canvas);
		}
		this.gl = js_html__$CanvasElement_CanvasUtil.getContextWebGL(this.canvas,null);
	}
	,compileShader: function(gl,shaderSource,shaderType) {
		var shader = gl.createShader(shaderType);
		gl.shaderSource(shader,shaderSource);
		gl.compileShader(shader);
		var success = gl.getShaderParameter(shader,35713);
		if(!success) {
			throw new js__$Boot_HaxeError("could not compile shader:" + gl.getShaderInfoLog(shader));
		}
		return shader;
	}
	,createProgram: function(gl,vertexShader,fragmentShader) {
		var program = gl.createProgram();
		gl.attachShader(program,vertexShader);
		gl.attachShader(program,fragmentShader);
		gl.linkProgram(program);
		var success = gl.getProgramParameter(program,35714);
		if(!success) {
			throw new js__$Boot_HaxeError("program failed to link:" + gl.getProgramInfoLog(program));
		}
		return program;
	}
	,createShaderFromScript: function(gl,scriptId,shaderType,opt_shaderType) {
		var shaderScript = window.document.getElementById(scriptId);
		if(shaderScript == null) {
			throw new js__$Boot_HaxeError("*** Error: unknown script element" + scriptId);
		}
		var shaderSource = shaderScript.text;
		if(opt_shaderType == null) {
			if(shaderScript.type == "x-shader/x-vertex") {
				shaderType = 35633;
			} else if(shaderScript.type == "x-shader/x-fragment") {
				shaderType = 35632;
			}
			if(opt_shaderType == null) {
				throw new js__$Boot_HaxeError("*** Error: shader type not set");
			}
		} else {
			window.console.warn("this might be a good idea in js world, I am not so sure");
		}
		return this.compileShader(gl,shaderSource,shaderType);
	}
	,createProgramFromScripts: function(gl,shaderScriptIds) {
		var vertexShader = this.createShaderFromScript(gl,shaderScriptIds[0],35633);
		var fragmentShader = this.createShaderFromScript(gl,shaderScriptIds[1],35632);
		return this.createProgram(gl,vertexShader,fragmentShader);
	}
	,setupProgram: function(vertexString,fragmentString) {
		var gl = this.gl;
		var shader = gl.createShader(35633);
		gl.shaderSource(shader,vertexString);
		gl.compileShader(shader);
		var vertex = shader;
		var gl1 = this.gl;
		var shader1 = gl1.createShader(35632);
		gl1.shaderSource(shader1,fragmentString);
		gl1.compileShader(shader1);
		var fragment = shader1;
		this.program = this.createProgram(this.gl,vertex,fragment);
		return this.program;
	}
};
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = "Date";
Object.defineProperty(js__$Boot_HaxeError.prototype,"message",{ get : function() {
	return String(this.val);
}});
js_Boot.__toStr = ({ }).toString;
sketcher_App.NAME = "[cc-sketcher]";
sketcher_webgl_WebGLSetup.posName = "pos";
sketcher_webgl_WebGLSetup.colorName = "color";
sketcher_webgl_WebGLSetup.textureName = "aTexture";
MainWebgl.main();
})({});

//# sourceMappingURL=cc_sketcher_webgl.js.map