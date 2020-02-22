package examples;

import sketcher.util.EmbedUtil;

class ExContainer {
	var fontFamily:String;

	public function new() {
		var inject = new html.CSSinjector(css());
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

		// var str = '|\ncanvas-wrapper|svg-wrapper\n|';
		// var str = '\n|\ncanvas-wrapper|svg-wrapper\n|\n||||\n|||\n||';

		var str = '.testclass|testid|#testid2';
		str += '\n|\ncanvas-wrapper|svg-wrapper\n|\n||||||||||||\n||||||||\n||||\n|||\n||\n|\n\n';
		var container = new html.Container(str);
	}

	/**
	 * use for debuggin
	 *
	 * @return String
	 */
	function css():String {
		return '
.col{
    min-height:20px;
    margin:1px;
    background-color:silver;
}
.testclass,
#testid,
#testid2,
#canvas-wrapper,
#svg-wrapper{
    width:100%;
    height:100%;
    padding:10px;
}

#canvas-wrapper{
    background-color: violet;
}
#svg-wrapper{
    background-color: turquoise;
}
#svg-wrapper:after{
    content:"#svg-wrapper";
}
#canvas-wrapper:after{
    content:"#canvas-wrapper";
}
.testclass{
    background-color: yellowgreen;
}
#testid{
    background-color: tomato;
}
#testid2{
    background-color: red;
}
#testid2:after{
    content:"#testid2";
}
#testid:after{
    content:"#testid";
}
.testclass:after{
    content:".testclass";
}
';

	}
}
