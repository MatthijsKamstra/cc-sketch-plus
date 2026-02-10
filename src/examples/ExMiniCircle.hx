package examples;

import js.Browser.*;

class ExMiniCircle {
	public function new() {
		var settings = new Settings(320, 220, 'svg');
		settings.elementID = 'sketcher-mini-circle';

		var sketch = Sketcher.create(settings).appendTo(document.body);
		var circle = sketch.makeCircle(160, 110, 70);
		circle.setFill('#ff6b35');
		circle.setStroke('#1f1f1f');
		circle.lineWeight = 3;

		sketch.update();
	}
}
