"use strict"
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
            game.spaceShip.update()

            game.nextEnemy -= 1
            if game.nextEnemy < 40
                game.enemyArray.push new game.enemy('one')
                game.enemyArray.push new game.enemy('two')
                game.nextEnemy = Math.random() * 220 + 40
            k = 0 # 敌人飞机添加 和碰撞检测
            while k < game.enemyArray.length
                game.enemyArray[k].update()
                if game.collide(game.spaceShip,game.enemyArray[k])
                    game.enemyArray[k].remove = true
                    game.audio.explodeMusic.load()
                    game.audio.explodeMusic.play()
                    game.enemyArray[k].life = 0
                    game.explodeArray.push new game.explode(game.enemyArray[k].x,game.enemyArray[k].y)
                    game.scores_num++
                if game.enemyArray[k].remove
                    game.enemyArray.splice k,1
                k++

            c = 0 # 子弹循环绘制 子弹与敌人碰撞
            while c < game.bulletArray.length
                game.bulletArray[c].update()
                a = 0
                while a < game.enemyArray.length
                    if game.collide(game.bulletArray[c],game.enemyArray[a])
                        game.bulletArray[c].remove = true
                        game.enemyArray[a].life--
                        if game.enemyArray[a].life <= 0
                            game.audio.explodeMusic.load()
                            game.audio.explodeMusic.play()
                            game.explodeArray.push new game.explode(game.enemyArray[a].x,game.enemyArray[a].y)
                            game.scores_num++
                    a++
                if game.bulletArray[c].remove
                    game.bulletArray.splice c,1
                c++


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
