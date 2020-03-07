import js.lib.Float32Array;
import sketcher.webgl.WebGLSetup;
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
		});
	}

	function setupDocument() {
		sketcher.util.EmbedUtil.bootstrapStyle();
		sketcher.util.EmbedUtil.datgui();

		var style = 'body{background-color:silver} canvas{border:1px solid gray;background-color:white; background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAFUlEQVQImWNgQAMXL178T3UBBgYGAIeiETu3apCOAAAAAElFTkSuQmCC)}}';
		new html.CSSinjector(style);
	}

	function setupCanvas() {
		var webgl = new WebGLSetup(800, 500);
		webgl.bgRed = 0;
		webgl.bgGreen = 0.5;
		webgl.bgBlue = 0;
		webgl.bgAlpha = 1;

		webgl.clearVerticesAndColors();

		var vs = '
attribute vec2 a_position;
void main(void) {
	gl_Position = vec4(a_position, 0.0, 1.0);
}
';

		var fs = '
void main(void) {
	gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);
}
';

		var program = webgl.setupProgram(vs, fs);
		var gl = webgl.gl;

		var array = new Float32Array([
			-1.0, -1.0,
			 1.0, -1.0,
			 1.0,  1.0,
			-1.0,  1.0
		]);

		vertices = new Array<Float>();
		indices = new Array<Int>();
		colors = new Array<Float>();

		WebGLSetup.uploadDataToBuffers(fl, program,);

		webgl.render();
	}

	static public function main() {
		var app = new MainWebgl();
	}
}
