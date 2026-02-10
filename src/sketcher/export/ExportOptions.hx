package sketcher.export;

typedef ExportOptions = {
	@:optional var format:ExportFormat;
	@:optional var fileName:String;
	@:optional var includeTimestamp:Bool;
	@:optional var metadata:Dynamic;
	@:optional var exportMetadataJson:Bool;
}
