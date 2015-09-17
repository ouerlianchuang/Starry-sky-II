#这是渲染函数 主要负责负责根据update 产生的数据 画出canvas上的元素
game.render = ->
    game.Draw.clear();
    game.ctx.drawImage game.backgroundImage,game.bImgX,game.bImgY,820,620,0,0,820,620
    if game.lworld is 'setup'　
        game.ctx.drawImage game.setup_window, 5 , 0, 295, 354, 262, 162, 295, 354 #背景框

    if game.lworld is 'setup' or game.lworld is 'begin' or game.lworld is 'help' or game.lworld is 'author'
        for i in [0..game.buttonArray.length-1]  #循环按钮
            game.ctx.drawImage game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h

    #需要修改方式
    #世界状态的方式好low
    #循环的 变量名 简直炸了
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
        if game.EndlessMode
            game.Draw.rect 0, 0, 820, 630, "rgba(0,0,0,1)"
            game.meteorArray
            mm = 0
            while mm < game.meteorArray.length
                game.meteorArray[mm].render()
                mm++
        game.radar.Draw game.ctx, game.rot #雷达区域的飞机
        if game.heroLife > 4
            game.ctx.drawImage game.bloodGrooveImage_bottom, 0, 0, 300, 24, 103, 585, 300, 24
            game.ctx.drawImage game.bloodGrooveImage_hp, 0, 0, 300, 24, 103, 585, game.heroLife*30, 24
            game.ctx.drawImage game.bloodGrooveImage_frame, 0, 0, 300, 24, 103, 585, 300, 24
        else if game.heroLife <= 4
            game.ctx.drawImage game.bloodGrooveImage_bottom_danger, 0, 0, 300, 24, 103, 585, 300, 24
            game.ctx.drawImage game.bloodGrooveImage_hp_danger, 0, 0, 300, 24, 103, 585, game.heroLife*30, 24
            game.ctx.drawImage game.bloodGrooveImage_frame_danger, 0, 0, 300, 24, 103, 585, 300, 24
        if game.heroLife <= 0
            game.pause = true
            game.failure = true

        #火球添加 碰撞
        fir = 0
        while fir < game.fireBallArray.length
            game.fireBallArray[fir].render()
            fir++
        #子弹绘制
        c = 0
        while c < game.bulletArray.length
            game.bulletArray[c].render()
            c++

        game.shipFlame.render game.rot #尾巴上的火焰
        game.spaceShip.Draw game.ctx, game.rot  # 画飞机 ✈️
        if game.gameTimeIn >= 1
            if game.bossScores > 0
                game.bossOneAllow = true
                if game.bossOneHintTime > 0
                    game.bossOneHintTime--
                    if game.bossOneHintTime % 20 is 0
                        if game. bossOneDangerHintImageAllow then game. bossOneDangerHintImageAllow = false else game. bossOneDangerHintImageAllow = true
                    if game. bossOneDangerHintImageAllow
                        game.bossOneHintSpeed+=2
                        game.ctx.drawImage game.bossDangerHintImage_bk, 0, 0
                        game.ctx.drawImage game.bossDangerHintImage_bottom, game.bossOneHintSpeed, 0, 820, 102, 0, 240, 820, 102
                        game.ctx.drawImage game.bossDangerHintImage_frame, 0, 240
                        game.ctx.drawImage game.bossDangerHintImage_text, 0, 240
        if game.bossOneAllow
            if game.bossOne.balltwo
                game.jiguangpao.render()
            bb = 0
            while bb < game.bossOneBallArray.length
                game.bossOneBallArray[bb].render()
                bb++
            game.bossOne.render()
        k = 0
        while k < game.enemyArray.length
            game.enemyArray[k].render()
            k++

        #爆炸图绘制
        b = 0
        while b < game.explodeArray.length
            game.explodeArray[b].render()
            b++
        #宝石
        g = 0
        while g < game.gemsArray.length
            game.gemsArray[g].render()
            g++
        ss = 0
        while ss < game.shieldSupplyArray.length
            game.shieldSupplyArray[ss].render()
            ss++
        p = 0 #能量颗粒
        while p < game.particleArray.length
            game.particleArray[p].render()
            p++

        t = 0 #能量字体
        while t < game.energyTextArray.length
            game.energyTextArray[t].render()
            t++
        #分数判断 火球危险等允许
        if game.gameTimeIn >= 0.5
            if game.fireBallHintTime > 0
                game.fireBallHintTime--
                if game.fireBallHintTime % 20 is 0
                    if game. fireBallDangerHintImageAllow then game. fireBallDangerHintImageAllow = false else game. fireBallDangerHintImageAllow = true
                if game.fireBallDangerHintImageAllow
                    game.ctx.drawImage game.fireBallDangerHintImage, 263.5, 180
        else
            game.fireBallAllow = true
        #武器系统
        if  game.weapons_system
            if game.weapons_system_x > 430
                game.weapons_system_x-=20
                game.ctx.drawImage game.weaponsSystemImage_frame, game.weapons_system_x, 220
            if game.weapons_system_x <= 430
                game.weapons_system_x = 430
                game.ctx.drawImage game.weaponsSystemImage_frame, game.weapons_system_x, 220
                game.ctx.drawImage game.gemsImage, 0, 0, 25, 25, 570, 240, 17, 17
                game.Draw.text game.gemsNum[0], 595, 252, 1, '#fff'
                game.ctx.drawImage game.gemsImage, 25, 0, 25, 25, 645, 240, 17, 17
                game.Draw.text game.gemsNum[1], 670, 252, 1, '#fff'
                game.ctx.drawImage game.gemsImage, 50, 0, 25, 25, 710, 240, 17, 17
                game.Draw.text game.gemsNum[2], 735, 252, 1, '#fff'
                game.ctx.drawImage game.gemsImage, 75, 0, 25, 25, 570, 260, 17, 17
                game.Draw.text game.gemsNum[3], 595, 272, 1, '#fff'
                game.ctx.drawImage game.gemsImage, 100, 0, 25, 25, 645, 260, 17, 17
                game.Draw.text game.gemsNum[4], 670, 272, 1, '#fff'
                game.ctx.drawImage game.gemsImage, 125, 0, 25, 25, 710, 260, 17, 17
                game.Draw.text game.gemsNum[5], 735, 272, 1, 'rgba(250, 250, 250, 0.5)'
                for a in [0..game.weapons_system_json["up_lv"]["xy"].length - 1]
                    if game.mouseX > game.weapons_system_json["open"]["xy"][a][0] and game.mouseY > game.weapons_system_json["open"]["xy"][a][1] and game.mouseX < game.weapons_system_json["open"]["xy"][a][0] + 50 and game.mouseY < game.weapons_system_json["open"]["xy"][a][1] + 20
                        game.weapons_system_json["open"]["Whether"][a][1] = 'weaponsSystemImage_open'
                    else
                        if !game.weapons_system_json["open"]["Whether"][a][0]
                            game.weapons_system_json["open"]["Whether"][a][1] = 'weaponsSystemImage_close'
                    game.weapons_system_json["open"]["Whether"][game.bulletStyle - 1][1] = 'weaponsSystemImage_open'
                    game.ctx.drawImage game[game.weapons_system_json["up_lv"]["Whether"][a][1]], game.weapons_system_json["up_lv"]["xy"][a][0], game.weapons_system_json["up_lv"]["xy"][a][1]
                    game.ctx.drawImage game[game.weapons_system_json["open"]["Whether"][a][1]], game.weapons_system_json["open"]["xy"][a][0], game.weapons_system_json["open"]["xy"][a][1]
        if game.statistics and not game.EndlessMode
            if game.statisticsTime > 0
                game.statisticsTime -= 1
                game.lvRandomNum++
                game.ctx.drawImage game.lvImage_bottom, 340, 200
                if game.lvRandomNum% 5 is 0
                    game.lvRandomSx = Math.round(Math.random()*4)*150
                game.ctx.drawImage game.lvImage_lv, game.lvRandomSx, 0, 150, 138, 330, 170, 150, 138,
                game.Draw.text "The damaged:", 140, 520, 15, 'rgba(250,250,250,1)' # 受损

                game.Draw.text "#{game.damage}", 260, 520, 15, 'rgba(250,250,250,1)'

                game.Draw.text "Bullet hurt:", 140, 540, 15,'rgba(250,250,250,1)'  # 伤害

                game.Draw.text "#{(game.hurt_show+=(game.hurt/200)).toFixed(2)}", 260, 540, 15, 'rgba(250,250,250,1)'

                game.Draw.text "Bullet ammoUse:", 140, 560, 15,'rgba(250,250,250,1)' #弹药消耗

                game.Draw.text "#{(game.ammoUse_show+=(game.ammoUse/200)).toFixed(2)}", 290, 560, 15, 'rgba(250,250,250,1)'

                game.Draw.text "The hitrate:", 390, 560, 15,'rgba(250,250,250,1)' #命中率

                game.Draw.text "#{(game.hit/game.ammoUse_show*100).toFixed(2)}%", 510, 560, 15, 'rgba(250,250,250,1)'
            else
                game.Draw.text "The damaged:", 140, 520, 15, 'rgba(250,250,250,1)' # 受损

                game.Draw.text "#{game.damage}", 260, 520, 15, 'rgba(250,250,250,1)'

                game.Draw.text "Bullet hurt:", 140, 540, 15,'rgba(250,250,250,1)'  # 伤害

                game.Draw.text "#{game.hurt}", 260, 540, 15, 'rgba(250,250,250,1)'

                game.Draw.text "Bullet ammoUse:", 140, 560, 15,'rgba(250,250,250,1)' #弹药消耗

                game.Draw.text "#{game.ammoUse}", 290, 560, 15, 'rgba(250,250,250,1)'

                game.Draw.text "The hitrate:", 390, 560, 15,'rgba(250,250,250,1)' #命中率

                game.Draw.text "#{(game.hit/game.ammoUse*100).toFixed(2)}%", 510, 560, 15, 'rgba(250,250,250,1)'
                game.ctx.drawImage game.lvImage_bottom, 340, 200 #等级 － －！随机的 不要在意
                if game.lvMidLeft < 241 and game.lvMidLeft > 100
                    game.audio.lvCollideMusic.play()
                if game.lvMidLeft <= 241
                    game.lvNum++
                    a = game.lvNum/41
                    game.lvMidLeft = game.lvMidLeft+241*a*a*a
                    game.lvMidRight = game.lvMidRight-241*a*a*a
                    game.ctx.drawImage game.lvImage_mid, 0, 0, 164, 132, game.lvMidLeft, 170, 164, 132
                    game.ctx.drawImage game.lvImage_mid, 164, 0, 164, 132, game.lvMidRight, 170, 164, 132
                else
                    game.ctx.drawImage game.lvImage_mid, 0, 0, 164, 132, 241, 170, 164, 132
                    game.ctx.drawImage game.lvImage_mid, 164, 0, 164, 132, 405, 170, 164, 132
                    game.ctx.drawImage game.ContinueChallengeImage, 500,375
                game.ctx.drawImage game.lvImage_lv, game.lvRandomSx, 0, 150, 138, 330, 170, 150, 138

        game.scores() #分数
        game.drawFrame() #最外层边框和能量区域
        if game.heroLife <= 4
            game.ctx.drawImage game.dangerImage, 0, 0
        #能量不足提示
        gi = 0
        while gi < game.energyHint.length
            game.energyHint[gi].render()
            gi++
        if game.pause
            if game.failure
                game.ctx.drawImage game.failureImage, 0, 0
                game.ctx.drawImage game.backImage_die, 500,375
            else
                game.ctx.drawImage game.pasuseImage, 310, 175
    game.target.render()
    return
