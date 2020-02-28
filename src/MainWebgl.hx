import sketcher.webgl.WebGl;
import js.Browser.*;
import js.html.webgl.ContextAttributes;
import js.html.webgl.Program;
import js.html.webgl.RenderingContext;
import js.html.webgl.Shader;
import js.html.webgl.UniformLocation;

using sketcher.webgl.WebGl;

class MainWebgl {
	/**
	 * canvas used for graphics
	 */
	public var canvas:js.html.CanvasElement;

	// canvan context
	public static var ctx:js.html.CanvasRenderingContext2D;
	// webgl?
	public static var gl:js.html.webgl.RenderingContext;

	//
	public var program:js.html.webgl.Program;

	public function new() {
		// super();
		document.addEventListener("DOMContentLoaded", function(event) {
			trace('MainWebgl');

			console.log('${sketcher.App.NAME} Dom ready :: build: ${sketcher.App.getBuildDate()}');

			setupDocument();
			setupCanvas();
			setupGL();
		});
	}

	function setupGL() {
		// // setup a GLSL program
		// var vertexShader = createShaderFromScriptElement(gl, "2d-vertex-shader");
		// var fragmentShader = createShaderFromScriptElement(gl, "2d-fragment-shader");
		// var program = createProgram(gl, [vertexShader, fragmentShader]);
		// gl.useProgram(program);

		// // look up where the vertex data needs to go.
		// var positionLocation = gl.getAttribLocation(program, "a_position");

		// // Create a buffer and put a single clipspace rectangle in
		// // it (2 triangles)
		// var buffer = gl.createBuffer();
		// gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
		// gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([
		// 	-1.0, -1.0,
		// 	 1.0, -1.0,
		// 	-1.0,  1.0,
		// 	-1.0,  1.0,
		// 	 1.0, -1.0,
		// 	 1.0,  1.0
		// ]), gl.STATIC_DRAW);
		// gl.enableVertexAttribArray(positionLocation);
		// gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);

		// // draw
		// gl.drawArrays(gl.TRIANGLES, 0, 6);
	}

	function setupDocument() {
		sketcher.util.EmbedUtil.bootstrapStyle();
		sketcher.util.EmbedUtil.datgui();

		var style = 'body{background-color:silver} canvas{border:1px solid gray;background-color:white; background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAFUlEQVQImWNgQAMXL178T3UBBgYGAIeiETu3apCOAAAAAElFTkSuQmCC)}}';
		new html.CSSinjector(style);
	}

	// public static inline var vertex:String = 'attribute vec3 coordinates;' //
	// 	+ 'void main(void) {' //
	// 	+ ' gl_Position = vec4(coordinates, 1.0);'
	// 	+ 'gl_PointSize = 10.0;' //
	// 	+ '}';
	// public static inline var fragment:String = 'void main(void) {' //
	// 	+ ' gl_FragColor = vec4(0.0, 0.0, 0.0, 0.1);' //
	// 	+ '}';

	function setupCanvas() {
		var webgl = new WebGl(500, 200);
		var gl = webgl.gl;

		gl.viewport(0, 0, webgl.canvas.width, webgl.canvas.height);
		gl.clearColor(0, 0.5, 0, 1);
		gl.clear(RenderingContext.COLOR_BUFFER_BIT);

		var vs = ' attribute vec2 aVertexPosition;
		void main() {
			gl_Position = vec4(aVertexPosition, 0.0, 1.0);
		}';

		var fs = 'uniform vec4 uColor;
		void main() {
			gl_FragColor = uColor;
		}';

		webgl.setupProgram(vs, fs);
	}

	static public function main() {
		var app = new MainWebgl();
	}
}
