var grid_size = 3;


 var board = JXG.JSXGraph.initBoard('jsxgraph-polar-1', {boundingbox: [-4, 4, 4, -4], 
 	grid:false, 
 	axis:true,
 	showCopyright:false,
 	zoom:false,
 	showNavigation:false});
 var board2 = JXG.JSXGraph.initBoard('jsxgraph-polar-2', {boundingbox: [-4, 4, 4, -4], 
 	axis:false, 
 	grid:false,
 	showCopyright:false,
 	zoom:false,
 	showNavigation:false});
 board.addChild(board2);

function f(x, y)
{
	return [x*Math.cos(y*Math.PI/grid_size), x*Math.sin(y*Math.PI/grid_size)];
}


function qX(){
	return f(p.X(), p.Y())[0];
}

function qY(){
	return f(p.X(), p.Y())[1];
}

function myfunc1(j)
{
	return [function(t){ return f(j, t)[0];}, function(t){ return f(j, t)[1];}];
}

function myfunc2(j)
{
	return [function(t){ return f(t, j)[0];}, function(t){ return f(t, j)[1];}];
}



for (var i = -grid_size; i <= grid_size; i++){
	board.create('segment', [[i, -grid_size], [i, grid_size]], {fixed: true, strokeColor: 'red', highlight:false});
	board2.create('curve', myfunc1(i), {strokeColor: 'red', strokeWidth:2, highlight:false});
	board.create('segment', [[-grid_size, i], [grid_size, i]], {fixed: true, strokeColor: 'red', highlight:false});	
	board2.create('curve', myfunc2(i), {strokeColor: 'red', strokeWidth:2, highlight:false});

}


 p = board.create('point', [1,2], {name: "$$\\huge \\color{blue}{\\mathbf{v}}$$", strokeColor: 'blue', fillColor: 'blue', fillOpacity: 0.3, size:5});


 q = board2.create('point', [qX, qY], {name: '$$\\huge \\color{blue}{T(\\mathbf{v})}$$', strokeColor: 'blue', fillColor: 'blue', fillOpacity:0.3, size:5});