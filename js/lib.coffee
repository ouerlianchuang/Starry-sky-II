"use strict"

#这个文件用来放置 功能函数 和 工厂函数

#canvas适应屏幕大小
game.resize = ->
    if window.innerHeight >= 620
        if window.innerWidth >= 820
            game.currentHeight = 620;
            game.currentWidth = 820;
        else
            game.currentWidth = window.innerWidth;
            game.currentHeight = game.currentWidth/game.ratio;
    else
        if window.innerWidth >= 820
            game.currentHeight = window.innerHeight;
            game.currentWidth = game.currentHeight * game.ratio;
        else
            game.currentWidth = window.innerWidth;
            game.currentHeight = game.currentWidth/game.ratio;

    game.canvas.style.width = game.currentWidth + 'px';
    game.canvas.style.height = game.currentHeight + 'px';
    game.scale = game.currentWidth/game.width;
    return

#画布清除 圆 方块等
game.Draw =
    clear : ->
        game.ctx.clearRect 0, 0, game.width, game.height
        return
    rect : (x,y,w,h,col) ->
        game.ctx.fillStyle = col
        game.ctx.fillRect x,y,w,h
        return
    circle : (x,y,r,col) ->
        game.ctx.fillStyle = col
        game.ctx.beginPath()
        game.ctx.arc x, y, r, 0, Math.PI * 2, true
        game.ctx.closePath()
        game.ctx.fill()
        return
    semiCircle  : (x,y,r,col,d) ->
        game.ctx.beginPath()
        game.ctx.arc 778, 603, 32, 0, Math.PI * (1 + d), 0
        game.ctx.strokeStyle = 'white'
        game.ctx.lineWidth = 3
        game.ctx.stroke()
        game.ctx.closePath()
        return
    text : (string,x,y,size,col) ->
        game.ctx.font = 'bold ' + size + 'px Monospace'
        game.ctx.fillStyle = col
        game.ctx.fillText string,x,y
        return

#鼠标位置
game.mousePosition =
    x: 0
    y: 0
    tapped: false
    set : (event) ->
        _x = _y = 0
        if event.pageX or event.pageY
            _x = event.pageX
            _y = event.pageY
        else
             _x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
             _y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop;
        _x -= game.canvas.offsetLeft;
        _y -= game.canvas.offsetTop;
        this.x = _x;
        this.y = _y;
        this.tapped = true;
        return
  # 外层框的绘制
game.drawFrame = ->
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
    #游戏边框
    game.ctx.drawImage game.gameFrameImage, 0 , 0, 820, 620, 0, 0, 820, 620
    return
# 瞄准
game.targetFn = (x,y) ->
    this.x = x
    this.y = y
    this.sx = 0
    this.n = 0
    this.rot = 0
    this.spin  = false #旋转
    this.on_off = 'on'
    this.update = ->
        this.n++
        if this.on_off is 'on'
            this.rot += 0.1
            if this.rot > 50
                this.spin = true
            if this.spin
                this.rot  -= 0.3
                if this.rot < 35
                    this.spin = false
                    this.rot = 0
        return
    this.render = ->
        game.ctx.save()
        game.ctx.translate(this.x,this.y) # 圆心
        game.ctx.rotate(this.rot % 360 ) * Math.PI / 180
        game.ctx.drawImage(game.targetImage, 0, 0, 25, 24, -12.5, -12, 25, 24)
        game.ctx.restore()
        return
    return

#图片载入
game.imageLoad = (array) ->
    for i in [0..array.length - 1]
        name = array[i][0]
        ImageName = array[i][1]
        game[name] = new Image()
        game[name].src = "./image/#{ImageName}"
        game[name].onload = ->
        game[name].onerror = ()->
            console.log name + "图片加载错误"
            return
    return
#声音载入
game.audioLoad = (array) ->
    for i in [0..array.length-1]
        my_name = array[i]['name']
        my_audio = array[i]['audio']
        my_volume = array[i]['volume'] or 0.4
        my_cycle = array[i]['cycle'] or false
        game.audio[my_name] = new Audio()
        game.audio[my_name].src = "./music/#{my_audio}"
        game.audio[my_name].volume = my_volume
        game.audio[my_name].volume_rem = my_volume #用来静音后恢复
        game.audio[my_name].volume_allow = true
        if my_cycle
            game.audio[my_name].addEventListener "ended", ->
                this.currentTime = 0
                this.load()
                this.play()
            , false
    return
#所有声音的开关
game.audioVolumeswitch = (key) ->
    if key is 'on'
        for key, value of game.audio
            game.audio[key].volume =  game.audio[key].volume_rem
            game.audio[key].volume_allow = true
    else
        for key, value of game.audio
            game.audio[key].volume =  0
            game.audio[key].volume_allow = false
#button
game.button = (x,y,w,h,state,image,name) ->
    this.x = x
    this.y = y
    this.w = w
    this.h = h
    this.state = state
    this.image = image
    this.name = name
    this.music = false
    this.musicNum = 0
    return
#go世界状态里的线条
game.line = ->
    this.type = 'go'
    this.x = 0
    this.y = parseInt Math.random() * 620
    this.r = parseInt Math.random() * 1.5
    this.opacity = 1
    this.fade = 0.05
    this.remove = false
    this.update = ->
        this.opacity -= this.fade
        this.remove = if this.opacity < 0 then true else false
        return
    this.render = ->
        game.Draw.rect this.x, this.y, 820, this.r, 'rgba(82,139,139,' + this.opacity + ')'
        return
    return

#Hero 英雄
game.hero = (x,y,w,h,shield) ->
    this.x = x
    this.y = y
    this.w = w
    this.h = h
    this.shield = shield
    this.imageShift = 40
    this.rotation = 0
    this.sx = 0
    this.rotate = 0 # 旋转
    this.update = ->
        if this.shield is 'shield_one'
            if this.rotate % 3 is 0
                this.sx += 115
            this.rotate++
            if this.sx is 690
                this.sx = 0

        if this.shield is 'shield_two'
            if this.rotate % 7 is 0
                this.sx += 86
            this.rotate++
        if this.sx is 344
            this.sx = 0
        return
    return
game.hero.prototype.Draw = (ctx,rot) ->
    this.rotation = rot
    ctx.save()
    if this.shield is 'initial' or this.shield is 'radar'
        this.image = game.heroImage
    if this.shield is 'shield_one'
        this.image = game.heroImage_one
    if this.shield is 'shield_two'
        this.image = game.heroImage_two
    ctx.translate this.x, this.y
    ctx.rotate this.rotation

    if this.shield is 'shield_one'
        this.w = 115
        this.h = 115
        ctx.drawImage this.image, this.sx , 0 , this.w , this.h, -this.w/2, -this.h/2, this.w ,this.h
    else if this.shield is 'shield_two'
        this.w = 86
        this.h = 115
        ctx.drawImage this.image, this.sx , 0 , this.w , this.h, -this.w/2, -this.h/2, this.w ,this.h
    else
        if this.shield is 'radar'
            this.w = this.w
            this.h = this.h
        else
            this.w = 66
            this.h = 66
        ctx.drawImage this.image, -this.w/2, -this.h/2, this.w, this.h
    ctx.restore()
    return
#火焰🔥
game.flame = ->
    this.sx = 0
    this.num = 0

    this.update = ->
        this.num++
        this.x = game.shipImgX
        this.y = game.shipImgY
        if this.num % 2 is 0
            this.sx += 40
        if this.sx > 320
            this.sx = 0
        return
    this.render = (rot) ->
        game.ctx.save()
        game.ctx.translate this.x, this.y
        game.ctx.rotate rot
        game.ctx.drawImage game.flameImage, this.sx, 0, 40, 40, -30, -20.5, 40, 40
        game.ctx.restore()
        return
    return
#分数
game.scores = (num)->
    if game.scores_num < 1000000 and  game.scores_num >= 100000
        game.scores_view = '' + game.scores_num
    else if game.scores < 100000 and  game.scores_num >= 10000
        game.scores_view = '0' + game.scores_num
    else if game.scores_num < 10000 and  game.scores_num >= 1000
        game.scores_view = '00' + game.scores_num
    else if game.scores_num < 1000 and  game.scores_num >= 100
        game.scores_view = '000' + game.scores_num
    else if game.scores_num < 100 and game.scores_num >= 10
        game.scores_view = '0000' + game.scores_num
    else if game.scores_num < 10
        game.scores_view = '00000' + game.scores_num
    for i in [0..game.scores_view.length-1]
        game.ctx.drawImage game.scoresImage, 0 + 17 * game.scores_view.charAt(i), 0, 17, 25 ,35 + 17 * i, 29, 17, 25
    return
#敌人
game.enemy = (enemy) ->
    this.type = enemy
    if this.type is 'one'
        this.image = game.enemyImage_one
        this.w = 103
        this.h = 59
        this.x = Math.random() * game.width
        this.y = game.height
        this.constant = this.x
    else if this.type is 'two'
        this.image = game.enemyImage_two
        this.w = 59
        this.h = 103
        this.x = game.width
        this.y = Math.random() * game.height
        this.constant = this.y
    this.life = 5
    this.r = Math.random() * 25 + 5
    this.speedScope = Math.random() * 3 + 1
    this.speed =  game.enemySpeed + this.speedScope
    this.waveSize = 60
    this.remove = false
    this.update = ->
        time = new Date().getTime()*0.002
        if this.type is 'one'
            this.y -= this.speed
            this.x = this.waveSize * Math.sin(time) + this.constant
        else if this.type is 'two'
            this.x -= this.speed
            this.y = this.waveSize * Math.sin(time) + this.constant
        if this.life is 0
            this.remove = true
        if this.type is 'one' and this.y < -10
            this.remove = true
        if this.type is 'two' and this.x < -10
            this.remove = true
        return
    this.render = ->
        game.ctx.drawImage this.image, this.x, this.y
        return
    return
#爆炸💥
game.explode = (x,y) ->
    this.x = x
    this.y = y
    this.sx = 0
    this.num = 0
    this.update = ->
        this.num++
        if this.num % 3 == 0
            this.sx += 120
        if this.sx > 1080
            this.remove = true
        return
    this.render = ->
        game.ctx.drawImage game.explodeImage, this.sx, 0, 120, 120, this.x, this.y, 120, 120
        return
    return
# 碰撞检测  记得要改
game.collide = (objA,objB)->
    if objA.x > objB.x && objA.x < objB.x+objB.w && objA.y < objB.y+objB.h && objA.y > objB.y
        return true
    return false
#子弹
game.bullet = (sx,sy,rot,g,t,img) ->
    this.x = sx
    this.y = sy
    this.bg = g
    this.bt = t
    this.brot = rot
    this.bimg = img
    this.remove = false
    this.update = ->
        this.x += Math.cos(this.brot) * 10
        this.y += Math.sin(this.brot) * 10
        this.remove = if this.x < 0 or this.x > 820 or this.y < 0 or this.y > 620 then true else false
        return
    this.render = ->
        game.ctx.save() #保存当前绘画状态
        game.ctx.translate this.x,this.y  #圆心
        game.ctx.rotate this.brot
        game.ctx.drawImage this.bimg, this.bg, this.bt
        game.ctx.restore();
        return
    return
window.addEventListener 'load',game.init,false
window.addEventListener 'resize',game.resize,false
























