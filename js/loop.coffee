game.loop = ->
	window.setTimeout game.loop,1000/60
	game.update
	game.render