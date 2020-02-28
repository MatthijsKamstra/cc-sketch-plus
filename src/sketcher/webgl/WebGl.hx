package sketcher.webgl;

import js.Browser.*;
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

using sketcher.webgl.WebGl;

/**
 * Ideal to inherit from WebGLSetup with 'using'.
 * Helper class for getting basic WebGL setup quickly.
 */
class WebGl {
	public var gl:RenderingContext;
	public var program:Program;
	public var width:Int;
	public var height:Int;
	public var canvas:CanvasElement;

	public function new(width:Int, height:Int, autoChild:Bool = true) {
		setupCanvas(width, height, autoChild);
	}

	/**
	 * Setup canvas for WebGL
	 */
	public function setupCanvas(width:Int, height:Int, autoChild:Bool = true) {
		this.width = width;
		this.height = height;
		canvas = document.createCanvasElement();
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
			document.body.appendChild(cast canvas);
		gl = canvas.getContextWebGL();
	}

	/**
	 * Creates and compiles a shader.
	 *
	 * @param {!WebGLRenderingContext} gl The WebGL Context.
	 * @param {string} shaderSource The GLSL source code for the shader.
	 * @param {number} shaderType The type of shader, VERTEX_SHADER or
	 *  RenderingContext FRAGMENT_SHADER.
	 * @return {!WebGLShader} The shader.
	 */
	public function compileShader(gl:RenderingContext, shaderSource:String, shaderType:Int) {
		// Create the shader object
		var shader = gl.createShader(shaderType);

		// Set the shader source code.
		gl.shaderSource(shader, shaderSource);

		// Compile the shader
		gl.compileShader(shader);

		// Check if it compiled
		var success = gl.getShaderParameter(shader, RenderingContext.COMPILE_STATUS);
		if (!success) {
			// Something went wrong during compilation; get the error
			throw "could not compile shader:" + gl.getShaderInfoLog(shader);
		}

		return shader;
	}

	/**
	 * Creates a program from 2 shaders.
	 *
	 * @param {!WebGLRenderingContext) gl The WebGL context.
	 * @param {!WebGLShader} vertexShader A vertex shader.
	 * @param {!WebGLShader} fragmentShader A fragment shader.
	 * @return {!WebGLProgram} A program.
	 */
	public function createProgram(gl:RenderingContext, vertexShader:Shader, fragmentShader:Shader) {
		// create a program.
		var program = gl.createProgram();

		// attach the shaders.
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);

		// link the program.
		gl.linkProgram(program);

		// Check if it linked.
		var success = gl.getProgramParameter(program, RenderingContext.LINK_STATUS);
		if (!success) {
			// something went wrong with the link
			throw("program failed to link:" + gl.getProgramInfoLog(program));
		}

		return program;
	}

	/**
	 * @exampe
	 *          var shader = compileShaderFromScript(gl, "someScriptTagId");
	 *
	 * Creates a shader from the content of a script tag.
	 *
	 * @param {!WebGLRenderingContext} gl The WebGL Context.
	 * @param {string} scriptId The id of the script tag.
	 * @param {string} opt_shaderType. The type of shader to create.
	 *     If not passed in will use the type attribute from the
	 *     script tag.
	 * @return {!WebGLShader} A shader.
	 */
	public function createShaderFromScript(gl:RenderingContext, scriptId:String, ?shaderType:Int, ?opt_shaderType:String) {
		// look up the script tag by id.
		var shaderScript:js.html.ScriptElement = cast document.getElementById(scriptId);
		if (shaderScript == null) {
			throw("*** Error: unknown script element" + scriptId);
		}

		// extract the contents of the script tag.
		var shaderSource = shaderScript.text;

		// If we didn't pass in a type, use the 'type' from
		// the script tag.
		if (opt_shaderType == null) {
			if (shaderScript.type == "x-shader/x-vertex") {
				// opt_shaderType = RenderingContext.VERTEX_SHADER;
				shaderType = RenderingContext.VERTEX_SHADER;
			} else if (shaderScript.type == "x-shader/x-fragment") {
				// opt_shaderType = RenderingContext.FRAGMENT_SHADER;
				shaderType = RenderingContext.FRAGMENT_SHADER;
			}
			if (opt_shaderType == null) {
				throw("*** Error: shader type not set");
			}
		} else {
			console.warn('this might be a good idea in js world, I am not so sure');
		}

		return compileShader(gl, shaderSource, shaderType);
	};

	/**
	 * Creates a program from 2 script tags.
	 *
	 * @param {!WebGLRenderingContext} gl The WebGL Context.
	 * @param {string[]} shaderScriptIds Array of ids of the script
	 *        tags for the shaders. The first is assumed to be the
	 *        vertex shader, the second the fragment shader.
	 * @return {!WebGLProgram} A program
	 */
	public function createProgramFromScripts(gl:RenderingContext, shaderScriptIds:Array<String>) {
		var vertexShader = createShaderFromScript(gl, shaderScriptIds[0], RenderingContext.VERTEX_SHADER);
		var fragmentShader = createShaderFromScript(gl, shaderScriptIds[1], RenderingContext.FRAGMENT_SHADER);
		return createProgram(gl, vertexShader, fragmentShader);
	}

	/**
	 * setup a program with shader strings
	 */
	public function setupProgram(vertexString:String, fragmentString:String):Program {
		var vertex = gl.shaderFromString(RenderingContext.VERTEX_SHADER, vertexString);
		var fragment = gl.shaderFromString(RenderingContext.FRAGMENT_SHADER, fragmentString);
		program = createProgram(gl, vertex, fragment);
		// program = gl.createShaderProgram(vertex, fragment);
		return program;
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
	 *      function drawScene() {
	 *          resize(gl.canvas);
	 *	        gl.viewport(0, 0, gl.canvas.width, gl.canvas.height);
	 *	   }
	 *	@param canvas
	 */
	static public function resize(canvas:js.html.CanvasElement) {
		// Lookup the size the browser is displaying the canvas.
		var displayWidth = canvas.clientWidth;
		var displayHeight = canvas.clientHeight;

		// Check if the canvas is not the same size.
		if (canvas.width != displayWidth || canvas.height != displayHeight) {
			// Make the canvas the same size
			canvas.width = displayWidth;
			canvas.height = displayHeight;
		}
	}
}
