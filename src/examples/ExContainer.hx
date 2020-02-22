package examples;

import sketcher.util.EmbedUtil;

class ExContainer {
	var fontFamily:String;

	public function new() {
		fontFamily = EmbedUtil.fontDisplay((e) -> {
			trace(e);
		});
		EmbedUtil.bootstrapStyle(onEmbedHandler);
	}

	function onEmbedHandler(e) {
		trace(e);
		init();
	}

	function init() {
		// var str = '|||';
		// var container = new html.Container(str);

		var str = '|\ncanvas-wrapper|svg-wrapper\n|';
		var container = new html.Container(str);
	}
}
