package tools;

#if macro
import haxe.Json;
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;
import sys.FileStat;
import sys.io.File;

using StringTools;

class Macro {
	public static var templateHTML = '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>::title::</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
<body>
	<div class="container">
	::title::
	</div>
	<!-- /.container -->

	<!-- Code generated using Haxe -->
	<script type="text/javascript" src="::js::"></script>

</body>
</html>';

	/**
	 * @example
	 * 			--macro tools.Macro.buildTemplate(true)
	 *
	 * @param overwrite
	 * @param folder
	 * @return Array<Field>
	 */
	public static function buildTemplate(?overwrite:Bool = false, ?folder:String = 'docs', ?js:String = '') {
		var cwd:String = Sys.getCwd();
		// trace(cwd);
		var exportFolder = Path.join([cwd, folder]);
		// trace(exportFolder);
		if (FileSystem.exists(exportFolder)) {
			generateTemplate(exportFolder, js);
		} else {
			Context.warning('You might be using a different folder structure: this will not work!', Context.currentPos());
		}
	}

	public static function generateTemplate(folder, js):Void {
		var file = {js: js, title: 'Generated'};
		var template = new haxe.Template(templateHTML);
		var output = template.execute(file);

		var fileName = folder + '/index.html';

		// trace(folder);
		// trace(output);
		// trace(fileName);

		File.saveContent(fileName, output);
	}

	private static function capFirstLetter(str:String):String {
		var tempstr = '';
		tempstr = str.substring(0, 1).toUpperCase() + str.substring(1, str.length);
		return tempstr;
	}
}
#end
