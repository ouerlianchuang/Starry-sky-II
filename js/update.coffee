#这是 数据更新函数 主要用来接收并改变游戏中会变的一切数值
game.update = ->
    game.target.x = game.mouseX
    game.target.y = game.mouseY
    game.target.update()

    if game.lworld is 'go'
        # for i in [0..game.whiteLine.length - 1] if 会出错误
        if game.opacityGoBlack > 0
            if game.opacityGoBlack > 0
                game.opacityGoBlack -= 0.002
            if game.opacityGoBlack <= 0.5
                game.opacityGoBlack_internal -= 0.004
            game.whiteLine.push new game.line()
            if game.opacityGoBlack > 0.5
                i = 0
                while i < game.whiteLine.length
                    game.whiteLine[i].update()
                    if game.whiteLine[i].remove is true
                        game.whiteLine.splice i,1
                    i++
        if game.opacityGoBlack < 0.5 and game.goIntroductionImageheigh < 253
            game.goIntroductionImageheigh += 0.2
    if game.lworld is 'gogo'
        if not game.pause
            if game.EndlessMode
                mm = 0
                while mm < game.meteorArray.length
                    game.meteorArray[mm].update()
                    if game.meteorArray[mm].remove
                        game.meteorArray[mm].x = Math.random() * 20 + 810
                        game.meteorArray[mm].y = Math.random() * 620
                        game.meteorArray[mm].remove = false
                    mm++
                game.nextEnemy -= 1
                if game.nextEnemy < 40
                    if game.gameTimeIn < 0.5
                        game.enemyArray.push new game.enemy('lv2one')
                        game.enemyArray.push new game.enemy('lv2two')
                        game.nextEnemy = Math.random() * 340 + 40
                    if game.gameTimeIn >= 0.5 and game.gameTimeIn < 1
                        game.enemyArray.push new game.enemy('lv2four')
                        game.enemyArray.push new game.enemy('lv2five')
                        game.enemyArray.push new game.enemy('lv2seven')
                        game.nextEnemy = Math.random() * 220 + 40
                    if game.gameTimeIn >= 1
                        game.enemyArray.push new game.enemy('lv2four')
                        game.enemyArray.push new game.enemy('lv2five')
                        game.enemyArray.push new game.enemy('lv2seven')
                        game.enemyArray.push new game.enemy('lv2eight')
                        game.nextEnemy = Math.random() * 120 + 40
            game.gameTimeIn = (new Date().getTime() - game.gameTime)/60000
            if game.energyValue > 0 and game.energyValue < 400
                game.energyValue -= 0.9
            else if game.energyValue >= 400
                game.energyValue -= 0.8
            if  game.energyValue >= 200
                game.spaceShip.shield = 'shield_one'
                game.shield = true
            else
                game.spaceShip.shield = 'initial'
                game.shield = false
            if game.energyValue > 750
                game.energyValue = 750
            #移动
            if game.leftkey
                game.shipImgX -= game.shipSpeed
                if game.shipImgX < 30
                    game.shipImgX = 30
                game.bImgX -= game.shipSpeed
                if game.bImgX < 0
                    game.bImgX = 0

            if game.rightkey
                game.shipImgX += game.shipSpeed
                if game.shipImgX >760
                    game.shipImgX = 760
                game.bImgX += game.shipSpeed
                if game.bImgX > 620
                    game.bImgX = 620

            if game.downkey
                game.shipImgY += game.shipSpeed
                if game.shipImgY > 570
                    game.shipImgY = 570
                game.bImgY += game.shipSpeed
                if game.bImgY > 820
                    game.bImgY = 820
            if game.upkey
                game.shipImgY -= game.shipSpeed
                if game.shipImgY < 40
                    game.shipImgY = 40
                game.bImgY -= game.shipSpeed
                if game.bImgY < 0
                    game.bImgY = 0

            game.spaceShip.x = game.shipImgX
            game.spaceShip.y = game.shipImgY
            game.spaceShip.update() #英雄机

            if not game.bossOneAllow
                if not game.EndlessMode
                    game.nextEnemy -= 1
                    if game.nextEnemy < 40
                        if game.gameTimeIn < 0.5
                            game.enemyArray.push new game.enemy('one')
                            game.enemyArray.push new game.enemy('two')
                            game.nextEnemy = Math.random() * 220 + 40
                        else if game.gameTimeIn >= 0.5 and game.gameTimeIn < 1
                            game.enemyArray.push new game.enemy('one')
                            game.enemyArray.push new game.enemy('two')
                            game.fireBallArray.push new game.fireBall()
                            game.nextEnemy = Math.random() * 120 + 40
            else
                game.bossOne.update()
                game.bossOneBallNum++
                if game.bossOne.balltwo
                    game.jiguangpao.update()
                if game.bossOne.ballone
                    game.bossOneBallTime++
                    if game.bossOneBallTime % 11 is 0
                        if game.bossOneBallOneAllow
                            game.bossOneBallArray.push new game.bossBall game.bossOne.x - 50, game.bossOne.y + 60, 2
                            game.bossOneBallArray.push new game.bossBall game.bossOne.x - 50, game.bossOne.y - 60, -2
                    if game.bossOneBallTime % 99 is 0
                        if game.bossOneBallOneAllow then game.bossOneBallOneAllow = false else game.bossOneBallOneAllow = true
                        game.bossOneBallArray.push new game.bossBall game.bossOne.x - 50, game.bossOne.y + 60, 0
                        game.bossOneBallArray.push new game.bossBall game.bossOne.x - 75, game.bossOne.y + 30, 0
                        game.bossOneBallArray.push new game.bossBall game.bossOne.x - 100, game.bossOne.y, 0
                        game.bossOneBallArray.push new game.bossBall game.bossOne.x - 75, game.bossOne.y - 30, 0
                        game.bossOneBallArray.push new game.bossBall game.bossOne.x - 50, game.bossOne.y - 60, 0
                        rot = 0
                        while rot <= 360
                            game.bossOneBallArray.push new game.bossBallTwo game.bossOne.x, game.bossOne.y, rot
                            rot += 30
                bb = 0
                while bb < game.bossOneBallArray.length
                    game.bossOneBallArray[bb].update()
                    if game.collide game.bossOneBallArray[bb], game.spaceShip, true
                        if game.quakeAllow
                            game.quakeAllow = false
                            clearInterval quakeTime
                            quakeNum = 45
                            quakeTime = setInterval ->
                                    if quakeNum%5 is 0
                                        game.bImgY += 4
                                    else
                                        game.bImgY -= 4
                                    if game.bImgY < 0
                                        game.bImgY = 0
                                    if game.bImgY > 620
                                        game.bImgY = 620
                                    quakeNum--
                                    if quakeNum < 0
                                       game.quakeAllow = true
                                       clearInterval quakeTime
                                ,130
                        game.bossOneBallArray[bb].remove = true
                        if game.shield
                            game.energyValue -= 80
                        else
                            game.heroLife--
                        game.damage++
                    if game.bossOneBallArray[bb].remove
                        game.bossOneBallArray.splice bb, 1
                    bb++
                #子弹和boss碰撞
                bab = 0
                while bab < game.bulletArray.length
                    if game.collide game.bulletArray[bab], game.bossOne, false
                        game.bossOne.life -= game.bulletPower
                        game.bulletArray[bab].remove = true
                        game.hurt += game.bulletPower
                        game.hit++
                        game.victoryOne = true
                        randomSupply = Math.random() * 10
                        if randomSupply <= 1
                            game.energyValue += 80
                            for pr in [0..60]
                                game.particleArray.push new game.particle game.bossOne.x, game.bossOne.y, 2
                            game.energyHint.push new game.shieldSupply game.bossOne.x, game.bossOne.y
                    if game.bulletArray[bab].remove
                        game.bulletArray.splice bab, 1
                    bab++
                if game.bossOne.life <= 0
                    game.bossOne.ballone = false
                    game.bossOne.balltwo = false
                    game.explodeArray.push new game.explode(game.bossOne.x+Math.random()*160 -80,game.bossOne.y+Math.random()*160 -80)
                    game.bossScores -= 2
                    game.scores_num += 2
                    if game.bossScores <= 0
                        game.bossOneAllow = false
                        game.statistics = true
                #boss结束
            #火球添加 碰撞
            fir = 0
            while fir < game.fireBallArray.length
                game.fireBallArray[fir].update()
                if game.collide game.spaceShip, game.fireBallArray[fir], false
                    if game.quakeAllow
                        game.quakeAllow = false
                        clearInterval quakeTime
                        quakeNum = 45
                        quakeTime = setInterval ->
                                if quakeNum%5 is 0
                                    game.bImgY += 4
                                else
                                    game.bImgY -= 4
                                if game.bImgY < 0
                                    game.bImgY = 0
                                if game.bImgY > 620
                                    game.bImgY = 620
                                quakeNum--
                                if quakeNum < 0
                                   game.quakeAllow = true
                                   clearInterval quakeTime
                            ,130
                    game.fireBallArray[fir].remove = true
                    if game.shield
                        game.energyValue -= 80
                    else
                        game.heroLife--
                    game.damage++
                if game.fireBallArray[fir].remove
                    game.fireBallArray.splice fir, 1
                fir++

            k = 0 # 敌人飞机添加 和碰撞检测
            while k < game.enemyArray.length
                game.enemyArray[k].update()
                if game.collide game.spaceShip, game.enemyArray[k], false
                    if game.quakeAllow
                        game.quakeAllow = false
                        clearInterval quakeTime
                        quakeNum = 45
                        quakeTime = setInterval ->
                                if quakeNum%5 is 0
                                    game.bImgY += 4
                                else
                                    game.bImgY -= 4
                                if game.bImgY < 0
                                    game.bImgY = 0
                                if game.bImgY > 620
                                    game.bImgY = 620
                                quakeNum--
                                if quakeNum < 0
                                   game.quakeAllow = true
                                   clearInterval quakeTime
                            ,130
                    game.enemyArray[k].remove = true
                    game.audio.explodeMusic.load()
                    game.audio.explodeMusic.play()
                    game.enemyArray[k].life = 0
                    game.explodeArray.push new game.explode(game.enemyArray[k].x,game.enemyArray[k].y)
                    game.scores_num++
                    for num in [0..randomNum]
                        game.gemsArray.push new game.gems game.enemyArray[k].x, game.enemyArray[k].y, game.shipImgX, game.shipImgY
                    for pr in [0..60]
                        game.particleArray.push new game.particle game.enemyArray[k].x, game.enemyArray[k].y, 2
                    if game.shield
                        game.energyValue -= 80
                    else
                        game.heroLife--
                    game.damage++
                if game.enemyArray[k].remove
                    game.enemyArray.splice k, 1
                k++

            c = 0 # 子弹循环绘制 子弹与敌人碰撞
            while c < game.bulletArray.length
                game.bulletArray[c].update()
                a = 0
                while a < game.enemyArray.length
                    if game.collide game.bulletArray[c], game.enemyArray[a], false
                        if game.quakeAllow
                            game.quakeAllow = false
                            clearInterval quakeTime
                            quakeNum = 45
                            quakeTime = setInterval ->
                                    if quakeNum%5 is 0
                                        game.bImgY += 4
                                    else
                                        game.bImgY -= 4
                                    if game.bImgY < 0
                                        game.bImgY = 0
                                    if game.bImgY > 620
                                        game.bImgY = 620
                                    quakeNum--
                                    if quakeNum < 0
                                       game.quakeAllow = true
                                       clearInterval quakeTime
                                ,130
                        game.bulletArray[c].remove = true
                        game.enemyArray[a].life -= game.bulletPower
                        game.hurt += game.bulletPower
                        game.hit++
                        if game.enemyArray[a].life <= 0
                            game.audio.explodeMusic.load()
                            game.audio.explodeMusic.play()
                            game.explodeArray.push new game.explode(game.enemyArray[a].x,game.enemyArray[a].y)
                            game.scores_num++
                            randomNum = Math.random() * 6 + 3
                            for num in [0..randomNum]
                                game.gemsArray.push new game.gems game.enemyArray[a].x, game.enemyArray[a].y, game.shipImgX, game.shipImgY
                            for pr in [0..60]
                                game.particleArray.push new game.particle game.enemyArray[a].x, game.enemyArray[a].y, 2
                    a++
                if game.bulletArray[c].remove
                    game.bulletArray.splice c, 1
                c++
            #宝石
            g = 0
            while g < game.gemsArray.length
                game.gemsArray[g].update()
                if game.collide game.gemsArray[g], game.spaceShip, true
                    game.shieldSupplyArray.push new game.gemsScores game.shipImgX, game.shipImgY, game.gemsArray[g].random
                    game.gemsArray[g].remove = true
                    game.gemsNum[game.gemsArray[g].random]++
                if game.gemsArray[g].remove
                    game.gemsArray.splice g, 1
                g++
            ss = 0
            while ss < game.shieldSupplyArray.length
                game.shieldSupplyArray[ss].update()
                if game.shieldSupplyArray[ss].remove
                    game.shieldSupplyArray.splice ss, 1
                ss++
            #能量不足提示
            gi = 0
            while gi < game.energyHint.length
                game.energyHint[gi].update()
                if game.energyHint[gi].remove
                    game.energyHint.splice gi, 1
                gi++

            p = 0 # 能量颗粒 能量字体
            while p < game.particleArray.length
                game.particleArray[p].update()
                if game.particleArray[p].remove
                    game.energyTextArray.push new game.energyText game.particleArray[p].x, game.particleArray[p].y
                    game.particleArray.splice p, 1
                p++

            t = 0
            while t < game.energyTextArray.length
                game.energyTextArray[t].update()
                if game.energyTextArray[t].remove
                    game.energyValue++
                    game.energyTextArray.splice t, 1
                t++

            #爆炸图添加
            b = 0
            while b < game.explodeArray.length
                game.explodeArray[b].update()
                if game.explodeArray[b].remove
                    game.explodeArray.splice b,1
                b++

            game.shipFlame.update()
            game.rot = Math.atan2 game.mouseY / game.scale - game.spaceShip.y, game.mouseX / game.scale - game.spaceShip.x
            return
