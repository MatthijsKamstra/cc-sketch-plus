package sketcher.webgl;

import js.Browser;
import js.html.Element;
import js.html.CanvasElement;
import js.html.BodyElement;
import js.html.webgl.RenderingContext;
import js.html.webgl.ContextAttributes;
import js.html.webgl.Shader;
import js.html.webgl.Program;
import js.html.webgl.UniformLocation;
import js.html.Image;
import haxe.io.UInt16Array;
import haxe.io.Float32Array;
import haxe.io.Int32Array;
import sketcher.webgl.WebGLSetup;

using sketcher.webgl.WebGLSetup;

typedef RGB = {
	var r:Float;
	var g:Float;
	var b:Float;
}

/**
 * Ideal to inherit from WebGLSetup with 'using'.
 * Helper class for getting basic WebGL setup quickly.
 */
class WebGLSetup {
	public var gl:RenderingContext;
	public var program:Program;
	public var width:Int;
	public var height:Int;
	public var canvas:CanvasElement;

	/**
	 * background red channel
	 */
	public var bgRed = 1.;

	/**
	 * background green channel
	 */
	public var bgGreen = 1.;

	/**
	 * background blue channel
	 */
	public var bgBlue = 1.;

	/**
	 * background alpha channel, may need consideration maybe not to use.
	 */
	public var bgAlpha = 1.;

	/**
	 * depth test Bool similar to cull.
	 */
	public var DEPTH_TEST = true;

	/**
	 * cull face Bool ( remove faces that are obscured by other faces )
	 */
	public var CULL_FACE = true;

	/**
	 * backface Bool ( when you flip an image in 3D it defines it should render back ).
	 */
	public var BACK = true;

	/**
	 * name used in vertex shader for coordinate data
	 */
	public static var posName = 'pos';

	/**
	 * name used in vertex shader for color data
	 */
	public static var colorName = 'color';

	/**
	 * name used in vertex shader for texture uv data
	 */
	public static var textureName = 'aTexture';

	/**
	 * transform matrix used in shader
	**/
	public var matrix32Array:Float32Array;

	/**
	 * vertices array provide to shader
	 */
	var vertices = new Float32Array(100);

	/**
	 * intermediatary colors array one entry per corner
	 */
	var triangleColors:Array<UInt>;

	/**
	 * indices array provided to shader
	 */
	var indices = new UInt16Array(100);

	/**
	 * colors array provided to shader
	 */
	var colors = new Float32Array(100);

	/**
	 * Constructor
	 */
	public function new(width_:Int, height_:Int, autoChild:Bool = true) {
		matrix32Array = ident(); // internal matrix passed to shader
		setupCanvas(width_, height_, autoChild);
	}

	/**
	 * Setup canvas for WebGL
	 */
	public function setupCanvas(width_:Int, height_:Int, autoChild:Bool = true) {
		width = width_;
		height = height_;
		canvas = Browser.document.createCanvasElement();
		canvas.width = width;
		canvas.height = height;
		var dom = cast canvas;
		var style = dom.style;
		style.paddingLeft = "0px";
		style.paddingTop = "0px";
		style.left = Std.string(0 + 'px');
		style.top = Std.string(0 + 'px');
		style.position = "absolute";
		if (autoChild)
			Browser.document.body.appendChild(cast canvas);
		gl = canvas.getContextWebGL();
	}

	/**
	 * setup a program with shader strings
	 */
	public function setupProgram(vertexString:String, fragmentString:String):Program {
		var vertex = gl.shaderFromString(RenderingContext.VERTEX_SHADER, vertexString);
		var fragment = gl.shaderFromString(RenderingContext.FRAGMENT_SHADER, fragmentString);
		program = gl.createShaderProgram(vertex, fragment);
		return program;
	}

	/**
	 * to upload an image to render.
	 */
	public function addImage(img:Image) {
		uploadImage(gl, img);
	}

	/**
	 * general clear buffer method may need suplementing, depending on use case.
	 */
	public function clearVerticesAndColors() {
		var vl = vertices.length;
		var il = indices.length;
		var cl = colors.length;
		vertices = new Float32Array(vl);
		indices = new UInt16Array(il);
		colors = new Float32Array(cl);
		// texture?
	}

	/**
	 * like ShaderInput but setup for indices.
	 */
	public static inline function passIndicesToShader(gl:RenderingContext, indices:UInt16Array) {
		var indexBuffer = gl.createBuffer(); // triangle indicies data
		gl.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, indexBuffer);
		gl.bufferData(RenderingContext.ELEMENT_ARRAY_BUFFER, untyped indices, RenderingContext.STATIC_DRAW);
		gl.bindBuffer(RenderingContext.ELEMENT_ARRAY_BUFFER, null);
	}

	/**
	 * alternative approach to setting up vertices and colors used by older experiments.
	 */
	public function setVerticesAndColors(vertices:Float32Array, triangleColors:Array<UInt>) {
		var rgb:RGB;
		var colorAlpha = 1.0;
		var len = colors.length;
		for (i in 0...Std.int(vertices.length / 3)) {
			rgb = toRGB(triangleColors[i]);
			for (j in 0...3) { // works but...
				colors[len++] = rgb.r;
				colors[len++] = rgb.g;
				colors[len++] = rgb.b;
				colors[len++] = colorAlpha;
			}
			indices.set(indices.length, i);
		}
		gl.passIndicesToShader(indices);
		gl.uploadDataToBuffers(program, vertices, colors);
	}

	/**
	 * main render loop
	**/
	public function render() {
		gl.clearColor(bgRed, bgGreen, bgBlue, bgAlpha);
		if (DEPTH_TEST)
			gl.enable(RenderingContext.DEPTH_TEST);
		if (CULL_FACE)
			gl.enable(RenderingContext.CULL_FACE);
		if (BACK)
			gl.cullFace(RenderingContext.BACK);
		// gl.disable(RenderingContext.CULL_FACE);

		gl.clear(RenderingContext.COLOR_BUFFER_BIT);
		gl.viewport(0, 0, canvas.width, canvas.height);
		var modelViewProjectionID = gl.getUniformLocation(program, 'modelViewProjection');
		/// you can update matrix32Array in the render loop.
		gl.uniformMatrix4fv(modelViewProjectionID, false, untyped matrix32Array);
		gl.drawArrays(RenderingContext.TRIANGLES, 0, indices.length);
	}

	/**
	 * converts a shader string to a shader and compiles it.
	 */
	public static inline function shaderFromString(gl:RenderingContext, shaderType:Int, shaderString:String) {
		var shader = gl.createShader(shaderType);
		gl.shaderSource(shader, shaderString);
		gl.compileShader(shader);
		return shader;
	}

	/**
	 * helper to create a shader program given a vertex and fragment shader.
	 */
	public static inline function createShaderProgram(gl:RenderingContext, vertex:Shader, fragment:Shader):Program {
		var program = gl.createProgram();
		gl.attachShader(program, vertex);
		gl.attachShader(program, fragment);
		gl.linkProgram(program);
		gl.useProgram(program);
		return program;
	}

	/**
	 * links shader input to buffer and program
	 */
	public static inline function shaderInput<T>(gl:RenderingContext, program:Program, name:String, att:Int, arr:T /*Float32Array */, number:Int) {
		var buffer = gl.createBuffer();
		var arrBuffer = RenderingContext.ARRAY_BUFFER;
		gl.bindBuffer(arrBuffer, buffer);
		// RenderingContext.FLOAT, RenderingContext.INT, RenderingContext.UNSIGNED_INT
		// Float32Array,Int32Array, Uint16Array
		gl.bufferData(arrBuffer, untyped arr, RenderingContext.STATIC_DRAW);
		var flo = gl.getAttribLocation(program, name);
		gl.vertexAttribPointer(flo, att, number, false, 0, 0);
		gl.enableVertexAttribArray(flo);
		gl.bindBuffer(arrBuffer, null);
	}

	/**
	 *  connects array data to shaders - vertices, colors and optional textures.
	 */
	public static inline function uploadDataToBuffers(gl:RenderingContext, program:Program, vertices:Float32Array, colors:Float32Array,
			?texture:Float32Array) {
		// , indices: Uint16Array ){
		gl.shaderInput(program, posName, 3, vertices, RenderingContext.FLOAT);
		gl.shaderInput(program, colorName, 4, colors, RenderingContext.FLOAT);
		if (texture != null)
			gl.shaderInput(program, textureName, 2, texture, RenderingContext.FLOAT);
	}

	/**
	 * Basic function to upload and link an image to a shader program
	 * TODO: Requires more generalization and testing.
	 */
	public static inline function uploadImage(gl:RenderingContext, image:Image) {
		var texture = gl.createTexture();
		gl.activeTexture(RenderingContext.TEXTURE0);
		gl.bindTexture(RenderingContext.TEXTURE_2D, texture);
		gl.pixelStorei(RenderingContext.UNPACK_FLIP_Y_WEBGL, 1);
		gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_S, RenderingContext.CLAMP_TO_EDGE);
		gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_WRAP_T, RenderingContext.CLAMP_TO_EDGE);
		gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MIN_FILTER, RenderingContext.NEAREST);
		gl.texParameteri(RenderingContext.TEXTURE_2D, RenderingContext.TEXTURE_MAG_FILTER, RenderingContext.NEAREST);
		gl.texImage2D(RenderingContext.TEXTURE_2D, 0, RenderingContext.RGBA, RenderingContext.RGBA, RenderingContext.UNSIGNED_BYTE, image);
	}

	/**
	 * splits Int into r,g,b object.
	 */
	public static inline function toRGB(int:Int):RGB {
		return {
			r: ((int >> 16) & 255) / 255,
			g: ((int >> 8) & 255) / 255,
			b: (int & 255) / 255
		}
	}

	/**
	 * provides an identity 4x4 matrix as Float32Array for shader transform
	 */
	public static inline function ident():Float32Array {
		var arr = new Float32Array(16);
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
	}
}
