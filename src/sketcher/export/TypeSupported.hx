package sketcher.export;

import js.html.MediaRecorder;
import js.Browser.*;

class TypeSupported {
	/**
	 * utils.TypeSupported.checkTypes();
	 */
	public static function checkTypes() {
		if (untyped window.MediaRecorder == undefined) {
			console.error('MediaRecorder not supported, boo');
		} else {
			// [mck] I have no idea what I am doing, so I let the browser give me the answer
			var contentTypes = [
				'video/ogg', 'audio/ogg;codecs=vorbis', 'video/mp4', 'audio/mp4', 'video/mp4;codecs=avc1', 'video/mp4;codecs="avc1.4d002a"', 'audio/mpeg',
				'video/x-matroska', 'video/x-matroska;codecs=avc1', 'video/quicktime', 'video/webm', 'video/webm;codecs=daala', 'video/webm;codecs=h264',
				'audio/webm;codecs=opus', 'audio/webm;codecs="opus"', 'video/webm;codecs=vp8', 'video/webm;codecs="vp8"', 'video/webm;codecs="vp9"',
				'audio/webm;codecs="vorbis"', 'video/webm;codecs="vp8,vorbis"', 'video/webm;codecs="vp9,opus"', 'video/invalid'

			];

			console.groupCollapsed("Check if codecs work:");
			for (i in 0...contentTypes.length) {
				// console.log("Is " + contentTypes[i] + " supported? " + (MediaRecorder.isTypeSupported(contentTypes[i]) ? "Maybe!" : "Nope :("));
				if (MediaRecorder.isTypeSupported(contentTypes[i])) {
					console.log('%c Is ${contentTypes[i]} supported? Maybe!', 'background: #444; color: #bada55; padding: 2px; border-radius:2px');
				} else {
					console.log("Is " + contentTypes[i] + " supported? " + (MediaRecorder.isTypeSupported(contentTypes[i]) ? "Maybe!" : "Nope :("));
				}
			}
			console.groupEnd();
			// console.log('%c Oh my heavens! ', 'background: #222; color: #bada55');
			// background: #444; color: #bada55; padding: 2px; border-radius:2px
		}
	}
}
