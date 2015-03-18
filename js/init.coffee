"use strict"
game.init  = ->
    game.ratio = game.width/game.height
    game.currentHeight = game.height
    game.currentWidth = game.width
    game.canvas = document.getElementsByTagName("canvas")[0]
    game.ctx = game.canvas.getContext "2d"
    game.canvas.width = game.width
    game.canvas.height = game.height
    game.resize()

    #声音加载
    game.audioLoad [
        {'name':'buttonHoverMusic', 'audio':'button.wav', 'volume': 0.7}
        {'name':'beginMusic', 'audio':'begin2.ogg', 'volume': 0.4, 'cycle':true}
        ]

    #图片加载 （方式有待改变） 暂时准备放在另一个json文件里 分游戏阶段来加载图片
    game.imageLoad [
            ['targetImage', 'target.png']   #瞄准图
            ['backgroundImage_login', 'login.jpg'] # 背景
            #首页button
            ['beginImage', 'begin.png']
            ['beginImage_hover', 'h_begin.png']
            ['setupImage', 'shezhi.png']
            ['setupImage_hover', 'h_shezhi.png']
            ['helpImage', 'bangzhu.png']
            ['helpImage_hover', 'h_bangzhu.png']
            ['authorImage', 'zhizuo.png']
            ['authorImage_hover', 'h_zhizuo.png']
            #设置页button
            ['voiceImage','shengyin.png']
            ['voiceImage_hover', 'shengyinguanbi.png']
            ['easyImage', 'jiandan.png']
            ['easyImage_hover', 'jiandan1.png']
            ['shookImage', 'chuangkoudoudong.png']
            ['shookImage_hover', 'chuangkoudoudong1.png']
            ['backImage', 'fanhui.png']
            ['backImage_hover', 'fanhuiyouxi1.png']
        ]

    #鼠标运动时禁止瞄准镜转动
    document.onmousemove = (e) ->
        if game.lworld is "begin"
            game.target.on_off = 'off'
            if timer
                clearTimeout timer
            timer = setTimeout ->
                        game.target.on_off = 'on'
                    , 500
        return

    #首页button hover触发函数 (≧∇≦) 比以前少好多
    game.buttonHover = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        for i in [0..game.buttonArray.length-1] #修复声音重复触发
            if game.buttonArray[i].music is true
                if game.buttonArray[i].musicNum <= 1
                    game.audio.buttonHoverMusic.load()
                    game.audio.buttonHoverMusic.play()
            if x > game.buttonArray[i].x and x <  game.buttonArray[i].x +  game.buttonArray[i].w and  y >  game.buttonArray[i].y and y <  game.buttonArray[i].y + game.buttonArray[i].h
                game.buttonArray[i].image = game["#{game.buttonArray[i].name}_hover"]
                game.buttonArray[i].music = true
                game.buttonArray[i].musicNum++
            else
                game.buttonArray[i].image = game[game.buttonArray[i].name]
                game.buttonArray[i].music = false
                game.buttonArray[i].musicNum = 0
        return

    #首页button 点击触发函数
    game.buttonUp = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        for i in [0..game.buttonArray.length-1] #修复声音重复触发
            if x > game.buttonArray[i].x and x <  game.buttonArray[i].x +  game.buttonArray[i].w and  y >  game.buttonArray[i].y and y <  game.buttonArray[i].y + game.buttonArray[i].h
                game.lworld = game.buttonArray[i].name.split('I')[0]  #改变世界状态
                if game.lworld isnt "begin"
                    window.removeEventListener 'mouseup', game.buttonUp
                else
                    game.lworld = 'go'

                if game.lworld is 'setup'
                    game.backgroundImage_login.src = './image/shezhiyemian.jpg'
                    game.buttonArray[0] = new game.button(310, 230, 177, 35, 'normal', game.voiceImage, 'voiceImage')
                    game.buttonArray[1] = new game.button(310, 285, 177, 35, 'normal', game.easyImage, 'easyImage')
                    game.buttonArray[2] = new game.button(310, 335, 177, 35, 'normal', game.shookImage, 'shookImage')
                    game.buttonArray[3] = new game.button(310, 390, 177, 35, 'normal', game.backImage, 'backImage')



    #屏蔽声音 后期加入设置
    for key, value of game.audio
        game.audio[key].volume = game.audio[key].volume_rem
       # game.audio[key].volume = game.audio[key].volume_rem

    #鼠标位置获取 同时
    window.addEventListener 'mousemove', (e) ->
        game.mousePosition.set(e)
        game.mouseX = game.mousePosition.x/game.scale
        game.mouseY = game.mousePosition.y/game.scale
        return

    window.addEventListener 'mousemove', game.buttonHover

    #window.removeEventListener 'mousemove', game.buttonHover

    window.addEventListener "mouseup", game.buttonUp

    #button数组
    game.buttonArray[0] = new game.button(565, 285, 172, 55, 'normal', game.beginImage, 'beginImage')
    game.buttonArray[1] = new game.button(585, 350, 123, 39, 'normal', game.setupImage, 'setupImage')
    game.buttonArray[2] = new game.button(585, 400, 123, 39, 'normal', game.helpImage, 'helpImage')
    game.buttonArray[3] = new game.button(585, 450, 123, 39, 'normal', game.authorImage, 'authorImage')

    #瞄准镜
    game.target = new game.targetFn(game.mouseX,game.mouseY)
    #执行循环函数
    game.loop()



