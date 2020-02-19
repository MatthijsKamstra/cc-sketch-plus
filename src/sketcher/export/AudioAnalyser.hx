package sketcher.export;

import js.Browser.*;
import js.html.AudioElement;
import js.html.audio.AnalyserNode;
import js.html.audio.AudioContext;
import sketcher.util.MathUtil;

class AudioAnalyser {
	/**
		Is an unsigned long value representing the size of the FFT (Fast Fourier Transform) to be used to determine the frequency domain.
		1024 default
	 */
	//
	public static var FFT_1024:Int = 1024; // default

	public static var FFT_512:Int = 512;
	public static var FFT_256:Int = 256;
	public static var FFT_128:Int = 128;
	public static var FFT_064:Int = 64;
	public static var FFT_032:Int = 32;

	//
	public static var FFT_2048:Int = 2048;
	public static var FFT_4096:Int = 4096;
	public static var FFT_8192:Int = 8192;
	public static var FFT_16384:Int = 16384;
	public static var FFT_32768:Int = 32768;

	public static var FFT_ARRAY:Array<Int> = [];

	// public static var FFT_65536:Int = 65536;
	// public static var FFT_131072:Int = 131072;
	// public static var FFT_262144:Int = 262144;
	// public static var FFT_524288:Int = 524288;
	// public static var FFT_1048576:Int = 1048576;
	// analyser
	var analyser:AnalyserNode;
	// var fftSize:Int = 1024;
	//
	var audioEl:AudioElement; // MediaElement;

	public var bufferLength:Int;
	public var frequencyData:js.lib.Uint8Array;
	public var timeDomainData:js.lib.Uint8Array;

	/**
	 * @source		https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/smoothingTimeConstant
	 *
	 * A double within the range 0 to 1 (0 meaning no time averaging). The default value is 0.8.
	 */
	@:isVar public var smoothingTimeConstant(get, set):Float;

	/**
	 * @source		https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode/fftSiz
	 *
	 * An unsigned integer, representing the window size of the FFT, given in number of samples. A higher value will result in more details in the frequency domain but fewer details in the time domain.
	 *
	 * Must be a power of 2 between 252^5 and 2152^15, so one of: 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, and 32768. Defaults to 2048.
	 */
	@:isVar public var fftSize(get, set):Int = 1024;

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
		FFT_ARRAY = [
			FFT_512, FFT_256, FFT_128, FFT_064, FFT_032, FFT_1024, FFT_2048, FFT_4096, FFT_8192, FFT_16384, FFT_32768
		];
	}

	public function setup():AnalyserNode {
		console.info('setup');

		// context
		var audioContext = new AudioContext();

		// analyser
		analyser = audioContext.createAnalyser();
		if (smoothingTimeConstant != null)
			analyser.smoothingTimeConstant = smoothingTimeConstant;
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

	// ____________________________________ getter/setter ____________________________________

	function get_smoothingTimeConstant():Float {
		return smoothingTimeConstant;
	}

	function set_smoothingTimeConstant(value:Float):Float {
		var v = MathUtil.clamp(value, 0, 1); // should between 0 and 1
		return smoothingTimeConstant = v;
	}

	function get_fftSize():Int {
		return fftSize;
	}

	function set_fftSize(value:Int):Int {
		var v = MathUtil.clamp(value, FFT_032, FFT_32768); // should between 32 and 32768
		return fftSize = Math.round(v);
	}
}
