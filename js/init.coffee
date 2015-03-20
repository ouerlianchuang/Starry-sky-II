"use strict"
game.init  = ->
    game.lworld = "begin"
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
        {'name': 'buttonHoverMusic', 'audio': 'button.wav', 'volume': 0.7}
        {'name': 'beginMusic', 'audio': 'begin2.ogg', 'volume': 0.4, 'cycle': true}
        {'name': 'middleMusic', 'audio': 'guochang.mp3', 'volume':0.3, 'cycle': true}
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
        ['setup_window', 'tanchuang2.png']

        #go页面
        ['backgroundImage_go', 'backg.jpg']
        ['gameFrameImage', 'backg2.png']
        ['energyTankUpImage', 'nengliangcaoshang.png']
        ['energyTankDownImage', 'nengliangcaoxia.png']
        ['energyTankImage', 'nengliangtiao.png']
        ['energyGuidingImage', 'nengliangzhizhen.png']
        ['energyStationImage', 'nengliangpan.png']
        ]

    #button数组  字面值有待修改 暂时想到 所有数据以后放在json
    game.begin_button = [
        new game.button(565, 285, 172, 55, 'normal', game.beginImage, 'beginImage')
        new game.button(585, 350, 123, 39, 'normal', game.setupImage, 'setupImage')
        new game.button(585, 400, 123, 39, 'normal', game.helpImage, 'helpImage')
        new game.button(585, 450, 123, 39, 'normal', game.authorImage, 'authorImage')
    ]

    game.setup_button = [
        new game.button(310, 230, 177, 35, 'normal', game.voiceImage, 'voiceImage')
        new game.button(310, 285, 177, 35, 'normal', game.easyImage, 'easyImage')
        new game.button(310, 335, 177, 35, 'normal', game.shookImage, 'shookImage')
        new game.button(310, 390, 177, 35, 'normal', game.backImage, 'backImage')
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
    game.buttonHover_begin = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        for i in [0..game.buttonArray.length-1]
            if game.buttonArray[i].music is true #修复声音重复触发
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
    game.buttonUp_begin = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        for i in [0..game.buttonArray.length-1]
            if x > game.buttonArray[i].x and x <  game.buttonArray[i].x +  game.buttonArray[i].w and  y >  game.buttonArray[i].y and y <  game.buttonArray[i].y + game.buttonArray[i].h
                game.lworld = game.buttonArray[i].name.split('I')[0]  #改变世界状态
                if game.lworld isnt "begin"
                    window.removeEventListener 'mouseup', game.buttonUp_begin
                else
                    game.lworld = "go"
                    game.backgroundImage_login.src = './image/backg.jpg'
                    game.audio.beginMusic.volume = 0.2
                    game.audio.middleMusic.play()

                if game.lworld is 'setup'
                    window.addEventListener 'mouseup', game.buttonUp_setup
                    game.backgroundImage_login.src = './image/shezhiyemian.jpg'
                    game.buttonArray = game.setup_button


    #设置页button 点击触发函数
    game.buttonUp_setup  = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        for i in [0..game.buttonArray.length-1]
            if x > game.buttonArray[i].x and x <  game.buttonArray[i].x +  game.buttonArray[i].w and  y >  game.buttonArray[i].y and y <  game.buttonArray[i].y + game.buttonArray[i].h
              if game.buttonArray[i].name.split('I')[0] is "back"
                 window.removeEventListener 'mouseup', game.buttonUp_setup
                 window.addEventListener 'mouseup', game.buttonUp_begin
                 game.lworld = 'begin'
                 game.backgroundImage_login.src = './image/login.jpg'
                 game.buttonArray = game.begin_button

    #屏蔽声音 后期加入设置
    for key, value of game.audio
        game.audio[key].volume =  game.audio[key].volume_rem
       # game.audio[key].volume = game.audio[key].volume_rem

    #鼠标位置获取 同时
    window.addEventListener 'mousemove', (e) ->
        game.mousePosition.set(e)
        game.mouseX = game.mousePosition.x/game.scale
        game.mouseY = game.mousePosition.y/game.scale
        return

    window.addEventListener 'mousemove', game.buttonHover_begin

    #window.removeEventListener 'mousemove', game.buttonHover

    window.addEventListener "mouseup", game.buttonUp_begin

    game.buttonArray = game.begin_button

    #瞄准镜
    game.target = new game.targetFn(game.mouseX,game.mouseY)
    game.audio.beginMusic.play()
    #执行循环函数
    game.loop()



