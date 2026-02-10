package examples;

import js.Browser.*;

class ExMiniRectangle {
	public function new() {
		var settings = new Settings(320, 220, 'svg');
		settings.elementID = 'sketcher-mini-rectangle';

		var sketch = Sketcher.create(settings).appendTo(document.body);
		var rect = sketch.makeRectangle(160, 110, 180, 120);
		rect.setFill('#2a9d8f');
		rect.setStroke('#1f1f1f');
		rect.lineWeight = 3;
		rect.setRotate(-6, 160, 110);

		sketch.update();
	}
}
