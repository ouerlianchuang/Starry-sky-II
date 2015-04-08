"use strict"
#这是渲染函数 主要负责负责根据update 产生的数据 画出canvas上的元素
game.render = ->
    game.Draw.clear();
    game.ctx.drawImage game.backgroundImage,game.bImgX,game.bImgY,820,620,0,0,820,620
    if game.lworld is 'setup'　
        game.ctx.drawImage game.setup_window, 5 , 0, 295, 354, 262, 162, 295, 354 #背景框

    if game.lworld is 'setup' or game.lworld is 'begin'
        for i in [0..game.buttonArray.length-1]  #循环按钮
            game.ctx.drawImage game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h

    #需要修改方式
    ###if game.lworld is 'help'
    if game.lworld is 'author'
    if game.lworld is 'gogo'###

    if game.lworld is 'go'
        game.drawFrame()
        #黑幕啊 黑幕
        if game.opacityGoBlack > 0
            game.Draw.rect 274, 135, 265, 298, 'rgba(0,0,0,'+game.opacityGoBlack_internal+')'

        #go世界状态下 弹窗
        game.ctx.drawImage game.setup_window, 5 , 0, 295, 354, 262, 112, 295, 354
        if game.lworld is 'go'
            for i in [0..game.buttonArray.length-1]
                game.ctx.drawImage game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h

        if game.opacityGoBlack > 0.5
            i = 0
            while i < game.whiteLine.length
                game.whiteLine[i].render()
                i++
        game.Draw.rect 0, 0, 820, 620, 'rgba(0,0,0,'+game.opacityGoBlack+')'

        if game.opacityGoBlack < 0.5 and game.goIntroductionImageheigh < 255 #说明文字的图片
            game.ctx.drawImage game.goIntroductionImage, 5 , 0, 295, 40+game.goIntroductionImageheigh, 262, 362-game.goIntroductionImageheigh, 295, 40+game.goIntroductionImageheigh

    if game.lworld is 'gogo'
        game.radar.Draw game.ctx, game.rot #雷达区域的飞机
        #子弹绘制
        c = 0
        while c < game.bulletArray.length
            game.bulletArray[c].render()
            c++

        game.shipFlame.render game.rot #尾巴上的火焰
        game.spaceShip.Draw game.ctx, game.rot  # 画飞机 ✈️
        k = 0
        while k < game.enemyArray.length
            game.enemyArray[k].render()
            k++

        #爆炸图绘制
         b = 0
         while b < game.explodeArray.length
            game.explodeArray[b].render()
            b++

        if  game.weapons_system
            game.ctx.drawImage game.weaponsSystemImage_frame, 430, 220
            for a in [0..game.weapons_system_json["up_lv"]["xy"].length - 1]
                if game.mouseX > game.weapons_system_json["open"]["xy"][a][0] and game.mouseY > game.weapons_system_json["open"]["xy"][a][1] and game.mouseX < game.weapons_system_json["open"]["xy"][a][0] + 50 and game.mouseY < game.weapons_system_json["open"]["xy"][a][1] + 20
                    game.weapons_system_json["open"]["Whether"][a][1] = 'weaponsSystemImage_open'
                else
                    if !game.weapons_system_json["open"]["Whether"][a][0]
                        game.weapons_system_json["open"]["Whether"][a][1] = 'weaponsSystemImage_close'
                game.ctx.drawImage game[game.weapons_system_json["up_lv"]["Whether"][a][1]], game.weapons_system_json["up_lv"]["xy"][a][0], game.weapons_system_json["up_lv"]["xy"][a][1]
                game.ctx.drawImage game[game.weapons_system_json["open"]["Whether"][a][1]], game.weapons_system_json["open"]["xy"][a][0], game.weapons_system_json["open"]["xy"][a][1]
        game.drawFrame() #最外层边框和能量区域
        game.scores() #分数
        if game.pause
             game.ctx.drawImage game.pasuseImage, 310, 175
    game.target.render()
    return
