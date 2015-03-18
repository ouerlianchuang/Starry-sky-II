"use strict"
game.render = ->
    game.Draw.clear();
    game.audio.beginMusic.play()
    game.ctx.drawImage(game.backgroundImage_login,game.bImgX,game.bImgY,820,620,0,0,820,620)

    for i in [0..game.buttonArray.length-1]
        game.ctx.drawImage(game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h)


    #需要修改方式

    ###if game.lworld is 'help'

    if game.lworld is 'author'

    if game.lworld is 'go'　

    if game.lworld is 'gogo'###


    game.target.render()
