package helper.audio;

import js.html.DivElement;
import js.Browser.*;

class AudioWrapper {
	var _id:String;
	var el:js.html.Element;

	// https://www.airtightinteractive.com/demos/js/uberviz/audioanalysis/js/AudioHandler.js

	/**
		*
				var audioWrapper = new AudioWrapper('audio-wrapper');

			 * @param id
	 */
	public function new(id:String) {
		this._id = id;

		el = document.getElementById(id);

		setup();
	}

	/**
		* // bootstrap
		*
		<div class="container">
			<div class="row">
				<div class="col-10">
				// audio
				</div>
				<div class="col-2">
					<div class="btn-group" role="group" aria-label="Basic example">
						<button type="button" class="btn btn-secondary">Left</button>
						<button type="button" class="btn btn-secondary">Middle</button>
						<button type="button" class="btn btn-secondary">Right</button>
					</div>
				</div>
			</div>
		</div>
	 */
	/**
	 * <audio id="audio-player" controls="controls" src="assets/mrrap.ogg" crossorigin="anonymous" preload="auto"></audio>
	 */
	function setup() {
		var audio = document.createAudioElement();
		audio.id = 'audio-player2';
		audio.src = 'assets/mrrap.ogg';
		audio.preload = 'auto';
		audio.autoplay = true;
		audio.controls = true;
		audio.crossOrigin = 'anonymous';

		// var str = '.col|col-sm-auto';
		// var container = new helper.html.Container(str);
		// container.isDebug();
		// container.attachToElement(el);

		// console.log(container);

		// trace(audio);
		// el.innerHTML = '<!-- audiowrapper -->';
		el.innerHTML = '<div class="container-fluid">
			<div class="row no-gutters">
				<div class="col" id="foo">
					<!-- inject audio -->
				</div>
				<div class="col-sm-auto">
					<div class="btn-group" role="group" aria-label="Basic example">
						<button type="button" class="btn btn-secondary" id="audio-reset-btn">Reset</button>
						<button type="button" class="btn btn-secondary" id="audio-mic-btn">Mic</button>
						<button type="button" class="btn btn-secondary" id="audio-upload-btn">Upload</button>

					<input id="audio_file" type="file" accept="audio/*"></input>
						</div>
				</div>
			</div>
		</div>';

		// el.appendChild(audio);
		document.getElementById('foo').appendChild(audio);

		var reset = document.getElementById('audio-reset-btn');
		reset.onclick = function(e) {
			trace('reset');
		}
		var reset = document.getElementById('audio-mic-btn');
		reset.onclick = function(e) {
			trace('mic');
		}
		var reset = document.getElementById('audio-upload-btn');
		reset.onclick = function(e) {
			trace('upload');
		}

		// https://stackoverflow.com/questions/30110701/how-can-i-use-js-webaudioapi-for-beat-detection/30112800
		/*
			audio_file.onchange = function() {
				var file = this.files[0];
				var reader = new FileReader();
				var context = new(window.AudioContext || window.webkitAudioContext) ();
				reader.onload = function() {
					context.decodeAudioData(reader.result, function(buffer) {
						prepare(buffer);
					});
				};
				reader.readAsArrayBuffer(file);
			};
		 */
	}
}
