"use strict"
game.resize = ->
    if window.innerHeight>=620
        if window.innerWidth>=820
            game.currentHeight =620;
            game.currentWidth =820;
        else
            game.currentWidth = window.innerWidth;
            game.currentHeight = game.currentWidth/game.ratio;
    else
        if window.innerWidth>=820
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
        if my_cycle
            game.audio[my_name].addEventListener "ended", ->
                this.currentTime = 0
                this.load()
                this.play()
            , false
    return
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


window.addEventListener('load',game.init,false);
window.addEventListener('resize',game.resize,false);
























