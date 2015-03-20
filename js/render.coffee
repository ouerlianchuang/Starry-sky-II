"use strict"
game.render = ->
    game.Draw.clear();
    game.ctx.drawImage game.backgroundImage_login,game.bImgX,game.bImgY,820,620,0,0,820,620
    if game.lworld is 'setup'　
        game.ctx.drawImage game.setup_window, 5 , 0, 295, 354, 262, 162, 295, 354

    if game.lworld is 'setup' or game.lworld is 'begin'
        for i in [0..game.buttonArray.length-1]
            game.ctx.drawImage game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h

    #需要修改方式

    ###if game.lworld is 'help'

    if game.lworld is 'author'

    if game.lworld is 'gogo'###
    if game.lworld is 'go'
        #能量区域
        game.ctx.drawImage game.energyTankDownImage, 0, 0
        game.ctx.drawImage game.energyTankImage, 0, 0, 200, 31, 635, 590, 200, 31
        game.ctx.drawImage game.energyTankUpImage, 0, 0
        game.ctx.drawImage game.energyStationImage, 720, 548

        #指针旋转
        if game.energyGuidingRotate is false
            game.energyGuidingRotateNum += 2
        else
            game.energyGuidingRotateNum -= 2
        if game.energyGuidingRotateNum >= 50
            game.energyGuidingRotate = true
        if game.energyGuidingRotateNum <= -50
            game.energyGuidingRotate = false
        game.ctx.save() #保存当前绘画状态
        game.ctx.translate 781, 608  #圆心
        game.ctx.rotate game.energyGuidingRotateNum % 360 * Math.PI / 180 #旋转角度
        game.ctx.drawImage game.energyGuidingImage, 0, 0, 16, 40, -8, -40, 16, 40
        game. ctx.restore();

        i = 0
        while i < game.whiteLine.length
            game.whiteLine[i].render()
            i++

        #游戏边框
        game.ctx.drawImage game.gameFrameImage, 0 , 0, 820, 620, 0, 0, 820, 620


    game.target.render()
