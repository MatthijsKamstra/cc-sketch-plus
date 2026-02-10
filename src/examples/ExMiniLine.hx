package examples;

import js.Browser.*;
import sketcher.draw.AST.LineCap;

class ExMiniLine {
	public function new() {
		var settings = new Settings(320, 220, 'svg');
		settings.elementID = 'sketcher-mini-line';

		var sketch = Sketcher.create(settings).appendTo(document.body);
		var line = sketch.makeLine(40, 180, 280, 40);
		line.strokeColor = '#264653';
		line.lineWeight = 8;
		line.lineCap = LineCap.Round;
		line.dash = [16, 12];

		sketch.update();
	}
}
