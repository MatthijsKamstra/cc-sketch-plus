/**
 * Globals.Globals has values you can access easily
 *
 * @usage:
 * 		import Globals.Globals.*;
 *
 * @source
 * 			https://groups.google.com/forum/#!topic/haxelang/CPbyE3WCvnc
 * 			https://gist.github.com/nadako/5913724
 */
class Globals {
	public static var MOUSE_DOWN:String = 'mousedown';
	public static var MOUSE_UP:String = 'mouseup';
	public static var MOUSE_MOVE:String = 'mousemove';
	public static var KEY_DOWN:String = 'keydown';
	public static var KEY_UP:String = 'keyup';
	public static var RESIZE:String = 'resize';
	public static var mouseX:Float;
	public static var mouseY:Float;
	public static var isMouseMoved:Bool;
	public static var isMouseDown:Bool = false;
	public static var keyDown:Int;
	public static var keyUp:Int;
	public static var mousePressed:Int = 0;
	public static var mouseReleased:Int = 0;
	public static var isFullscreen:Bool = false;
	public static var TWO_PI:Float = Math.PI * 2;

	// allows me global access to canvas and it’s width and height properties
	public static var w:Float;
	public static var h:Float;
	public static var w2:Float;
	public static var h2:Float;
}
