package draw;

class AST {}

// import draw.AST.LineCap;
enum abstract LineCap(String) {
	var Butt = 'butt'; // default
	var Round = 'round';
	var Square = 'square';
}


// arcs | bevel |miter | miter-clip | round
// // import draw.AST.LineJoin;
enum abstract LineJoin(String) {
	var Arcs = 'arcs';
	var Bevel = 'bevel';
	var Miter = 'miter'; // default
	var MiterClip = 'miter-clip';
	var Round = 'round';
}

