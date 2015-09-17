#这是初始函数  加载图片 声音 绑定事件
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
        { 'name': 'buttonHoverMusic',    'audio' : 'button.wav',          'volume': 0.3}
        { 'name': 'beginMusic',          'audio' : 'begin2.ogg',          'volume': 0.1, 'cycle': true}
        { 'name': 'warMusic',            'audio' : '吴欣睿 - 临危.mp3',     'volume': 0.1, 'cycle': true}
        { 'name': 'middleMusic',         'audio' : 'guochang.mp3',        'volume': 0.1, 'cycle': true}
        { 'name': 'bullteMusic',         'audio' : 'zidanmusic1.wav',     'volume': 0.1, 'cycle': true}
        { 'name': 'explodeMusic',        'audio' : 'baozhamusic.mp3',     'volume': 0.5}
        { 'name': 'weaponssSystemMusic', 'audio' : 'wuqixitongdakai.wav', 'volue': 1}
        { 'name': 'lvCollideMusic',      'audio' : 'lvzhuangji.wav', 'volue': 1}
    ]

    #图片加载 （方式有待改变） 暂时准备放在另一个json文件里 分游戏阶段来加载图片
    game.imageLoad [
        ['targetImage', 'target.png']   #瞄准图
        ['backgroundImage', 'login.jpg'] # 背景
        ['backgroundImage_help', 'bangzhu.jpg']
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
        ['voiceOffImage','shenyinguanbi.png']
        ['voiceImage_hover', 'shengyinkaiqihover.png']
        ['voiceOffImage_hover', 'shengyinguanbi.png']
        ['easyImage', 'jiandan.png']
        ['easyImage_hover', 'jiandan1.png']
        ['shookImage', 'chuangkoudoudong.png']
        ['shookImage_hover', 'chuangkoudoudong1.png']
        ['backImage', 'fanhui.png']
        ['backImage_hover', 'fanhuiyouxi1.png']
        ['backInImage', 'fanhuicaidan.png']
        ['backInImage_hover', 'fanhuicaidan.png']
        ['setup_window', 'tanchuang2.png']

        #go页面
        ['backgroundImage_go', 'backg.jpg']
        ['gameFrameImage', 'backg2.png']
        ['energyTankUpImage', 'nengliangcaoshang.png']
        ['energyTankDownImage', 'nengliangcaoxia.png']
        ['energyTankImage', 'nengliangtiao.png']
        ['energyGuidingImage', 'nengliangzhizhen.png']
        ['energyStationImage', 'nengliangpan.png']
        ['goBeginImage', 'b.png']
        ['goBeginImage_hover', 'b2.png']
        ['goIntroductionImage', 'gojieshao.png']
        # hero
        ['heroImage', 'self5.png']
        ['heroImage_shield_one', 'feiji.png']
        ['heroImage_shield_two', 'hudun.png']
        ['flameImage', 'weiyan.png']
        #分数
        ['scoresImage', 'fenshuimg.png']
        #enemy 敌人
        ['enemyImage_one', 'diren1.png']
        ['enemyImage_two', 'diren2.png']
        #explode 爆炸
        ['explodeImage', 'baozha.png']
        #bullet 子弹
        ['bulletImage_one', '/bullet/1.png']
        ['bulletImage_two', '/bullet/2.png']
        ['bulletImage_three', '/bullet/1a.png']
        ['bulletImage_four', '/bullet/2a.png']
        ['bulletImage_five', '/bullet/1c.png']
        ['bulletImage_six', '/bullet/4.png']
        ['bulletImage_seven', '/bullet/222.png']
        #武器系统  weapons_system
        ['weaponsSystemImage_frame', 'wuqixitong.png']
        ['weaponsSystemImage_button_one', 'qianghuaanniu1.png']
        ['weaponsSystemImage_button_two', 'qianghuaanniu2.png']
        ['weaponsSystemImage_open', 'qiyong2.png']
        ['weaponsSystemImage_close', 'qiyong1.png']
        #暂停
        ['pasuseImage', 'zanting.png']
        #血槽
        ['bloodGrooveImage_bottom', 'xuecaodi1.png']
        ['bloodGrooveImage_bottom_danger', 'xuecaodi2.png']
        ['bloodGrooveImage_hp', 'xuetiao1.png']
        ['bloodGrooveImage_hp_danger', 'xuetiao2.png']
        ['bloodGrooveImage_frame', 'xuecao1.png']
        ['bloodGrooveImage_frame_danger', 'xuecao2.png']
        #血量过低危险状态
        ['dangerImage', 'weixianzhuangtai.png']
        #宝石['failureImage', 'shibai.png']
        ['gemsImage', 'baoshi.png']
        ['gemsScoresImage', 'jiafen.png']
        #失败
        ['failureImage', 'shibai.png']
        # 火球
        ['fireBallDangerHintImage', 'jinggao.png']
        ['fireBallImage', 'huoqiu.png']
        #boss 警告
        ['bossDangerHintImage_bottom', 'weixianjinggaodibu.png']
        ['bossDangerHintImage_frame', 'weixianjinggao.png']
        ['bossDangerHintImage_text', 'weixianjinggaozi.png']
        ['bossDangerHintImage_bk', 'bossxuese.png']
        ['bossImage', 'boss1.png']
        ['bossBallImage', '/bullet/boss1.png']
        ['bossBallImage_two', '/bullet/13.png']
        ['bossjiguangImage', '/bullet/14.png']
        #护盾 能量 补给
        ['shieldSupplyImage', 'hudunbuji.png']
        #胜利后的 等级  s a b c d
        ['lvImage_bottom', 'dengji-pi.png']
        ['lvImage_mid', 'dengji-di.png']
        ['lvImage_lv', 'dengji.png']
        #返回游戏和继续挑战
        ['backImage_die', 'fanhuicaidan.png']
        ['ContinueChallengeImage', 'jixutiaozhan.png']
        #lv2
        ['enemyImage_one_lv2', '/lv2/1.png']
        ['enemyImage_two_lv2', '/lv2/2.png']
        ['enemyImage_three_lv2', '/lv2/3.png']

        ['enemyImage_four_lv2', '/lv2/4.png']
        ['enemyImage_five_lv2', '/lv2/8.png']
        ['enemyImage_six_lv2', '/lv2/10.png']

        ['enemyImage_seven_lv2', '/lv2/Mech1A.png']
        ['enemyImage_eight_lv2', '/lv2/Mech3.png']
        ['enemyImage_nine_lv2', '/lv2/Mech4.png']
        ]
     #button数组  字面值有待修改 暂时想到 所有数据以后放在json
    game.begin_button = [
        new game.button 565, 285, 172, 55, 'normal', game.beginImage, 'beginImage'
        new game.button 585, 350, 123, 39, 'normal', game.setupImage, 'setupImage'
        new game.button 585, 400, 123, 39, 'normal', game.helpImage, 'helpImage'
        new game.button 585, 450, 123, 39, 'normal', game.authorImage, 'authorImage'
    ]
    game.setup_button = [
        new game.button 310, 230, 177, 35, 'normal', game.voiceImage, 'voiceImage'
        new game.button 310, 285, 177, 35, 'normal', game.easyImage, 'easyImage'
        new game.button 310, 335, 177, 35, 'normal', game.shookImage, 'shookImage'
        new game.button 310, 390, 177, 35, 'normal', game.backImage, 'backImage'
    ]
    game.help_button = [
        new game.button 600, 540, 177, 35, 'normal', game.backInImage, 'backInImage'
    ]
    game.author_button = [
        new game.button 600, 540, 177, 35, 'normal', game.backInImage, 'backInImage'
    ]
    game.go_button = [
        new game.button 364, 405, 73, 24, 'normal', game.goBeginImage, 'goBeginImage'
    ]
    #鼠标运动时禁止瞄准镜转动
    document.onmousemove = (e) ->
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
    #go世界状态button 点击触发函数
    game.buttonUp_go = (e) ->
        e.preventDefault()
        x = game.mouseX
        y = game.mouseY
        if x > 364 and x < 437 and y > 405 and y < 429
            if game.opacityGoBlack <= 0
                game.lworld = "gogo"
                game.gameTime = new Date().getTime()
                game.audio.middleMusic.load()
                game.audio.beginMusic.load()
                game.audio.warMusic.play()
                window.removeEventListener 'mousemove', game.buttonHover_begin
                window.removeEventListener 'mouseup', game.buttonUp_go
                window.addEventListener 'keydown', game.directionKeyDown
                window.addEventListener 'keyup', game.directionKeyUp


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
                    game.backgroundImage.src = './image/backg.jpg'
                    if game.audio.beginMusic.volume_allow
                        game.audio.beginMusic.volume = 0.2
                    game.audio.middleMusic.play()
                    window.removeEventListener 'mouseup', game.buttonUp_begin
                    window.addEventListener 'mouseup', game.buttonUp_go
                    game.buttonArray = game.go_button #加上这句 会报本函数中 x undefined

                if game.lworld is 'setup'
                    window.addEventListener 'mouseup', game.buttonUp_setup
                    game.backgroundImage.src = './image/shezhiyemian.jpg'
                    game.buttonArray = game.setup_button
                if game.lworld is 'help'
                    window.addEventListener 'mouseup', game.buttonUp_setup
                    game.backgroundImage.src = './image/bangzhu.jpg'
                    game.buttonArray = game.help_button
                if game.lworld is 'author'
                    window.addEventListener 'mouseup', game.buttonUp_setup
                    game.backgroundImage.src = './image/tuandui.jpg'
                    game.buttonArray = game.author_button
        return
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
                 game.backgroundImage.src = './image/login.jpg'
                 game.buttonArray = game.begin_button
        return

    # hero 移动允许
    game.directionKeyDown = (e) ->
        if  game.lworld is "gogo"
            switch e.keyCode
                when 87 then game.upkey = true
                when 83 then game.downkey = true
                when 65 then game.leftkey = true
                when 68 then game.rightkey = true
                else return

    game.directionKeyUp = (e) ->   #关闭 方向移动 允许
        if  game.lworld is "gogo"
            switch e.keyCode
                when 87 then game.upkey = false
                when 83 then game.downkey = false
                when 65 then game.leftkey = false
                when 68 then game.rightkey = false
                when 82
                    if game.weapons_system then (game.weapons_system = false; game.weapons_system_x = 820)else game.weapons_system = true
                    if game.weapons_system
                        game.audio.weaponssSystemMusic.load()
                        game.audio.weaponssSystemMusic.play()
                else return

    game.bulletGo =(x,y) -> #点击发射子弹
        game.bulletTime++
        game.audio.bullteMusic.play()
        switch game.bulletStyle #子弹类型判断
            when 1 then if game.bulletTime % 5 is 0
                game.bulletPower = 1
                game.ammoUse++
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, game.rot, -12.5, -6, game.bulletImage_one
            when 2 then if game.bulletTime % 3 is 0
                game.ammoUse++
                game.bulletPower = 1
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY + 5, game.rot, -9, -4, game.bulletImage_two
            when 3 then if game.bulletTime % 2 is 0
                game.ammoUse++
                game.bulletPower = 1
                rr = game.rot + ( Math.random() * 0.5 - 0.27 )
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, rr, -20, -10, game.bulletImage_three
            when 4 then if game.bulletTime % 2 is 0
                game.ammoUse++
                game.bulletPower = 2
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, game.rot, -12.5, -7.5, game.bulletImage_four
            when 5 then if game.bulletTime % 4 is 0
                game.ammoUse++
                game.bulletPower = 3
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, game.rot, -24.5, -30, game.bulletImage_five
            when 6 then if game.bulletTime % 2 is 0
                game.ammoUse++
                game.bulletPower = 3
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, game.rot, -20, -7.5, game.bulletImage_six
            when 7 then if game.bulletTime % 8 is 0
                game.ammoUse++
                game.bulletPower = 3
                game.bulletArray.push new game.bullet game.shipImgX, game.shipImgY, game.rot, -20, -8, game.bulletImage_seven
        game.bulletAllow = window.requestAnimationFrame game.bulletGo # 循环执行
        return

    document.onmouseup = (e)->
        if game.lworld is 'setup'
            if game.mouseX > game.setup_button[0].x and game.mouseX < game.setup_button[0].x + game.setup_button[0].w and game.mouseY > game.setup_button[0].y and game.mouseY< game.setup_button[0].y + game.setup_button[0].h
                if game.audioAllow then game.audioAllow = false else game.audioAllow = true
                if game.audioAllow
                    game.audioVolumeswitch('on')
                    game.setup_button[0].image = game.voiceImage
                    game.setup_button[0].name =  'voiceImage'
                else
                    game.audioVolumeswitch('off')
                    game.setup_button[0].image = game.voiceOffImage
                    game.setup_button[0].name =  'voiceOffImage'
        if game.lworld is 'gogo'  #如果世界状态   gogo  可以发射子弹
            game.audio.bullteMusic.load()  #声音
            game.bulletTime = 0  #子弹时间
            window.cancelAnimationFrame game.bulletAllow #子弹push结束
            game.bulletAllow = null
            if game.failure
                if game.mouseX > 500 and game.mouseY > 375 and game.mouseX < 600 and game.mouseY < 395
                    window.location.reload()
            if game.statistics
                if game.mouseX > 500 and game.mouseY > 375 and game.mouseX < 600 and game.mouseY < 395
                    game.EndlessMode = true
                    game.gameTime = new Date().getTime()
                    game.nextEnemy = 200
            if game.weapons_system # 武器系统的点击
                for a in [0..game.weapons_system_json["up_lv"]["xy"].length - 1]
                    if game.mouseX > game.weapons_system_json["open"]["xy"][a][0] and game.mouseY > game.weapons_system_json["open"]["xy"][a][1] and game.mouseX < game.weapons_system_json["open"]["xy"][a][0] + 50 and game.mouseY < game.weapons_system_json["open"]["xy"][a][1] + 20
                        if game.gemsNum[a] > 10
                            game.bulletStyle = a + 1
                            game.gemsNum[a] -= 10
                        else
                           game.energyHint.push new game.hint game.weapons_system_json["open"]["xy"][a][0], game.weapons_system_json["open"]["xy"][a][1]
        return
    document.onmousedown = (e)->
        if game.lworld is 'gogo' and !game.pause
            x = game.mouseX
            y = game.mouseY
            game.bulletGo(x,y)
        return

    document.oncontextmenu = (e)->
        e.preventDefault()
        if game.pause then game.pause = false else game.pause = true
        return false
    #屏蔽声音 后期加入设置
    game.audioVolumeswitch('on')

    #鼠标位置获取 同时
    window.addEventListener 'mousemove', (e) ->
        game.mousePosition.set(e)
        game.mouseX = game.mousePosition.x/game.scale
        game.mouseY = game.mousePosition.y/game.scale
        return

    window.addEventListener 'mousemove', game.buttonHover_begin

    window.addEventListener "mouseup", game.buttonUp_begin

    game.buttonArray = game.begin_button

    #瞄准镜
    game.target = new game.targetFn game.mouseX, game.mouseY

    #hero
    game.spaceShip = new game.hero game.shipImgX, game.shipImgY, 66, 66, 'initial'

    #第二关 的模拟流星
    for m in [0..200]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.4, 0.5, 0.1, 'red'
    for m in [0..100]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.6, 1, 0.1, 'red'
    for m in [0..50]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.4, 1, 0.1, 'red'
    for m in [0..20]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.4, 1.5, 0.4,
    for m in [0..20]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.6, 1.5, 0.5,
    for m in [0..10]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.2, 1.5, 1,
    for m in [0..2]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.6, 3, 2,
    for m in [0..2]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.6, 3, 1,
    for m in [0..2]
        game.meteorArray.push new game.meteor Math.random()*820, Math.random()*620, 0.6, 3, 4,


    #雷达n
    game.radar = new game.hero 61, 576, 50, 50, 'radar'
    #boss
    game.bossOne = new game.boss()
    game.jiguangpao = new game.jiguang()
    #flame
    game.shipFlame = new game.flame()
    game.audio.beginMusic.play()
    #执行循环函数
    game.loop()



