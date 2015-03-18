"use strict"
game.loop = ->
	window.requestAnimationFrame game.loop
	game.update()
	game.render()