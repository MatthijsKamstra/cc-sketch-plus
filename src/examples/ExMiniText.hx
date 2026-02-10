package examples;

import js.Browser.*;
import sketcher.draw.Text.TextAlignType;
import sketcher.draw.Text.TextBaselineType;

class ExMiniText {
	public function new() {
		var settings = new Settings(320, 220, 'svg');
		settings.elementID = 'sketcher-mini-text';

		var sketch = Sketcher.create(settings).appendTo(document.body);
		var text = sketch.makeText('HELLO', 160, 110);
		text.fillColor = '#e76f51';
		text.fontSize = '48px';
		text.textAlign = TextAlignType.Center;
		text.textBaseline = TextBaselineType.Middle;

		sketch.update();
	}
}
