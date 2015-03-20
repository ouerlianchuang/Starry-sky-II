"use strict"
game.update = ->
    game.target.x = game.mouseX
    game.target.y = game.mouseY
    game.target.update()

    if game.lworld is 'go'
        game.whiteLine.push new game.line()
        i = 0
        while i < game.whiteLine.length
            game.whiteLine[i].update()
            if game.whiteLine[i].remove is true
                game.whiteLine.splice i,1
            i++
        # for i in [0..game.whiteLine.length - 1]
