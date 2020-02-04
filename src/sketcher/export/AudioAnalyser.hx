package sketcher.export;

import js.html.audio.AnalyserNode;
import js.html.audio.AudioContext;
import js.html.AudioElement;
import js.Browser.*;

class AudioAnalyser {
	/**
		Is an unsigned long value representing the size of the FFT (Fast Fourier Transform) to be used to determine the frequency domain.
		1024 default
	 */
	//
	public static var FFT_1024:Int = 1024;

	public static var FFT_512:Int = 512;
	public static var FFT_256:Int = 256;
	public static var FFT_128:Int = 128;
	public static var FFT_64:Int = 64;
	public static var FFT_32:Int = 32;

	//
	public static var FFT_2048:Int = 2048;
	public static var FFT_4096:Int = 4096;
	public static var FFT_8192:Int = 8192;
	public static var FFT_16384:Int = 16384;
	public static var FFT_32768:Int = 32768;
	public static var FFT_65536:Int = 65536;
	public static var FFT_131072:Int = 131072;
	public static var FFT_262144:Int = 262144;
	public static var FFT_524288:Int = 524288;
	public static var FFT_1048576:Int = 1048576;

	// analyser
	var analyser:AnalyserNode;
	var fftSize:Int = 1024;
	//
	var audioEl:AudioElement; // MediaElement;

	public var bufferLength:Int;
	public var frequencyData:js.lib.Uint8Array;
	public var timeDomainData:js.lib.Uint8Array;

	/**
	 * [Description]
	 *
	 * @example
	 * 			var analyser:AnalyserNode;
	 *          var audioAnalyser = new AudioAnalyser(audioEl, AudioAnalyser.FFT_512);
	 *          analyser = audioAnalyser.setup();
	 *
	 * @param audioEl
	 * @param fftSize
	 */
	public function new(audioEl:js.html.AudioElement, fftSize:Int = 1024) {
		this.audioEl = audioEl;
		this.fftSize = fftSize;
	}

	public function setup():AnalyserNode {
		console.info('setup');

		// context
		var audioContext = new AudioContext();

		// analyser
		analyser = audioContext.createAnalyser();
		analyser.fftSize = fftSize; // default 1024 data points // The fftSize must be set to a power of two

		// data
		bufferLength = analyser.frequencyBinCount;
		frequencyData = new js.lib.Uint8Array(bufferLength);
		timeDomainData = new js.lib.Uint8Array(bufferLength);

		// connect audio
		var source = audioContext.createMediaElementSource(audioEl);
		// Connect the output of the source to the input of the analyser
		source.connect(analyser);
		// Connect the output of the analyser to the destination
		analyser.connect(audioContext.destination);
		// make sure the analyser is added

		return analyser;
	}

	public function update() {
		// console.info('update');
		analyser.getByteFrequencyData(frequencyData); // default
		analyser.getByteTimeDomainData(timeDomainData); // <- usuable
	}
}
