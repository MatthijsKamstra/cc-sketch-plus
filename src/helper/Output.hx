package helper;

import js.Browser.*;

class Output {
	/**
	 * var out = new helper.Output('canvas-waveform');
	 *
	 * @param id		attach to id
	 */
	public function new(id:String) {
		var el = document.getElementById(id);
		console.log(el);

		var input = document.createInputElement();
		input.type = 'text';
		input.value = 'hello';
		input.setAttribute('style', 'display: block;position: absolute;top: 0;font-family: inherit;font-size: small;line-height: normal;');
		el.appendChild(input);
	}
}
