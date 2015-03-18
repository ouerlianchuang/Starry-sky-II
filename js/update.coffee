"use strict"
game.update = ->
	game.target.x = game.mouseX
	game.target.y = game.mouseY
	game.target.update()