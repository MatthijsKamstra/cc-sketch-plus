package sketcher.export;

import js.html.audio.AudioContext;
import js.html.CanvasElement;
import js.html.AudioElement;
import js.html.*;
import js.Browser.*;

class VideoExport {
	// canvas
	var canvas:CanvasElement;
	var ctx:CanvasRenderingContext2D;
	// audio
	var audioEl:AudioElement; // AudioElement;
	// preview/download (usefull but not needed)
	var videoEl:VideoElement;
	var downloadButtonEl:AnchorElement;
	// record video/audio stream into one
	var options:MediaRecorderOptions;
	var audioRecorder:MediaRecorder;
	var videoRecorder:MediaRecorder;
	var combineRecorder:MediaRecorder;
	var combinedStream:MediaStream;

	/**
	 * @example
	 * 			var videoExport = new VideoExport();
	 * 			videoExport.setCanvas(mycanvas);
	 * 			// videoExport.setSvg(mysvg);
	 * 			videoExport.setAudio(myaudio);
	 * 			videoExport.setDownload(myanchorbutton); // optional
	 * 			videoExport.setVideo(mypreviewvideo); // optional
	 * 			videoExport.setup(); // activate everything
	 */
	public function new() {
		TypeSupported.checkTypes();
	}

	public function setCanvas(canvas:js.html.CanvasElement):Void {
		this.canvas = canvas;
	}

	/**
	 * set the input of the audio
	 * @param audio 	set as AudioElement (video- and audio-element) [mck] see if this can be audio element only
	 * @param isActive
	 */
	public function setAudio(audio:AudioElement, isActive:Bool = true):Void {
		this.audioEl = audio;
		if (isActive) {
			this.audioEl.onplay = () -> {
				console.info('Play audio');
				startRecording();
			};
			this.audioEl.onpause = () -> {
				console.info('Stop audio');
				stopRecording();
			};
		}
	}

	public function setDownload(downloadButton:AnchorElement):Void {
		this.downloadButtonEl = downloadButton;
		this.downloadButtonEl.classList.add('disabled');
	}

	public function setOptions(options:MediaRecorderOptions):Void {
		this.options = options;
	}

	public function setVideo(video:VideoElement):Void {
		this.videoEl = video;
	}

	public function setup():Void {
		// default 2.5Mbps -->
		if (this.options == null) {
			this.options = {
				bitsPerSecond: 5500000
			}
		}
		// setup audio and video
		setupCombineRecordings();
		if (audioEl != null)
			setupAudioRecording();
		setupCanvasRecording();
	}

	/**
	 * start recording
	 */
	public function start() {
		console.info('start recording');
		startRecording();
	}

	/**
	 * stop recording
	 */
	public function stop() {
		console.info('stop recording');
		stopRecording();
	}

	// ____________________________________ setup controle Audio ____________________________________

	function startRecording() {
		// console.info('startRecording');
		if (audioRecorder != null)
			audioRecorder.start();
		videoRecorder.start();
		combineRecorder.start();
	}

	function stopRecording() {
		// console.info('stopRecording');
		if (audioRecorder != null)
			audioRecorder.stop();
		videoRecorder.stop();
		combineRecorder.stop();
	}

	// ____________________________________ setup ____________________________________

	function setupCanvasRecording() {
		var canvasStream:CanvasCaptureMediaStream = canvas.captureStream();
		// combine canvas video stream with audiotrack (later)
		var videoTrack = canvasStream.getTracks()[0];
		combinedStream.addTrack(videoTrack);
		// record
		videoRecorder = new MediaRecorder(canvasStream, options);
		videoRecorder.ondataavailable = e -> {
			onVideoRecordingReady(e);
		};
	}

	function setupAudioRecording() {
		console.info('setupAudioRecording');

		var audioContext = new AudioContext();
		var source = audioContext.createMediaElementSource(audioEl);

		// The media element source stops audio playout of the audio element.
		// Hook it up to speakers again.
		source.connect(audioContext.destination);

		// Hook up the audio element to a MediaStream.
		var audioStream = audioContext.createMediaStreamDestination();
		// combinedStream audio and video (audio here)
		var audioTrack = audioStream.stream.getTracks()[0];
		combinedStream.addTrack(audioTrack);

		source.connect(audioStream);

		// Record audio with audioRecorder.
		audioRecorder = new MediaRecorder(audioStream.stream, options);
		audioRecorder.ondataavailable = e -> {
			onAudioRecordingReady(e);
		};
	}

	function setupCombineRecordings() {
		console.info('setupCombineRecordings');
		combinedStream = new MediaStream();

		combineRecorder = new MediaRecorder(combinedStream, options);
		combineRecorder.ondataavailable = e -> {
			onCombineRecordingReady(e);
		}
	}

	// ____________________________________ on record ready ____________________________________

	function onAudioRecordingReady(e) {
		console.info("Finished onAudioRecordingReady. Got blob:", e.data); // Got blob:	Blob {size: 67769, type: "audio/ogg; codecs=opus"}
		//
		// var audioEl:js.html.AudioElement = cast document.getElementById('audio-recording');
		// // e.data contains a blob representing the recording
		// audioEl.src = URL.createObjectURL(e.data);
		// audioEl.play();
	}

	function onVideoRecordingReady(e) {
		console.info("Finished onVideoRecordingReady. Got blob:", e.data);
		//
		// var videoEl:js.html.VideoElement = cast document.getElementById('video-recording');
		// var videoData = [e.data];
		// var blob = new Blob(videoData, {'type': 'video/webm'});
		// var videoURL = URL.createObjectURL(blob);
		// videoEl.src = videoURL;
		// videoEl.src = URL.createObjectURL(e.data);
		// videoEl.play();
	}

	function onCombineRecordingReady(e) {
		console.info("Finished onCombineRecordingReady. Got blob:", e.data);
		var videoUrl = URL.createObjectURL(e.data);
		var blob = new Blob(cast [e.data]);
		if (videoEl != null) {
			// var videoEl:js.html.VideoElement = cast document.getElementById('video-export');
			// videoEl.src = URL.createObjectURL(blob);
			videoEl.src = videoUrl;
			videoEl.play();
		} else {
			// [mck] not really needed
			// console.warn('No videoEl is not created yet');
		}
		var filename = 'RecordedVideo_${Date.now().getTime()}';
		if (downloadButtonEl != null) {
			downloadButtonEl.href = videoUrl;
			downloadButtonEl.download = '$filename.webm';
			downloadButtonEl.classList.remove('disabled');
		} else {
			// console.warn('No downloadButtonEl is not created yet');
			var d = document.createAnchorElement();
			d.setAttribute('style', 'padding:10px; margin:10px; background-color:silver;');
			d.innerText = 'Download: $filename.webm (${blob.size} bytes)';
			d.href = videoUrl;
			d.download = '$filename.webm';
			d.classList.remove('disabled');
			document.body.appendChild(d);
		}
		console.info("Successfully recorded " + blob.size + " bytes of " + blob.type + " media.");
		console.warn('#!/bin/bash'
			+ '\n\n'
			+ '# [mck] for now just convert to mp4 seems the best solution'
			+ '\n\n'
			+ 'say "start convert webm to mp4"'
			+ '\n'
			+ 'ffmpeg -i ${filename}.webm\n'
			+ 'ffmpeg -y -i ${filename}.webm ${filename}.mp4\n'
			+ 'ffmpeg -y -r 30 -i ${filename}.webm -c:v libx264 -strict -2 -pix_fmt yuv420p -shortest -filter:v "setpts=0.5*PTS" ${filename}_30fps.mp4\n'
			+ 'ffmpeg -y -r 60 -i ${filename}.webm -c:v libx264 -strict -2 -pix_fmt yuv420p -shortest -filter:v "setpts=0.5*PTS" ${filename}_60fps.mp4\n'
			+ 'ffmpeg -y -r 30 -i ${filename}.mp4 -c:v libx264 -strict -2 -pix_fmt yuv420p -shortest -filter:v "setpts=0.5*PTS" ${filename}_30fps_inputmp4.mp4'
			+ '\n'
			+ 'say "end convert webm to mp4"');
	}
}
