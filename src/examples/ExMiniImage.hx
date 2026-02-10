package examples;

import js.Browser.*;

class ExMiniImage {
	public function new() {
		var settings = new Settings(320, 220, 'svg');
		settings.elementID = 'sketcher-mini-image';

		var sketch = Sketcher.create(settings).appendTo(document.body);
		sketch.makeRectangle(160, 110, 220, 140).setFill('#f4f1de');
		var img = sketch.makeImage(160, 110, 'https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png', 140, 140, true);
		img.setStroke('#1f1f1f');
		img.lineWeight = 2;

		sketch.update();
	}
}
