"use strict"
#游戏空间 圈定各种初始值和开关
game =
    mouseX: 0
    mouseY: 0

    canvas: null
    ctx: null

    scale: 1 #缩放比例
    ratio: null #宽高比例
    width: 820
    height: 620
    currentWidth: null #现在宽度
    currentHeight: null
    bImgX: 0 #背景图位置
    bImgY: 0
    shipImgX: 300 #飞机位置
    shipImgY: 300
    music: 1


    lworld: 'begin' #世界状态
    bossOne: false  #boss允许

    bulletArray: []
    bulletTime: 0 #子弹时间
    bulletPower: 1 #子弹威力  待 实现
    bulletAllow: null  #子弹循环开关
    bulletStyle: 2 #子弹类型
    bulletNum: 0
    bulletConsume: 0  #子弹损耗

    damage: 0 #损伤
    damage_show : 0
    hit: 0 #命中
    ammoUse: 0 #弹药消耗
    ammoUse_show : 0
    hurt: 0 #伤害
    hurt_show : 0
    hitrate: 0 #命中率

    openShield: false #开启护盾
    quakeAllow: false #震动允许

    heroLife: 10
    infiniteLife: false #无限生命

    whiteLine: [] #go世界状态下线条存储
    buttonArray: [] # 按钮数组
    audio: {} #声音数组
    audioAllow : true


    energyValue:0 #能量值
    shield : false
    #能量指针旋转
    energyGuidingRotate: false
    energyGuidingRotateNum : -50

    #黑幕黑幕的透明度
    opacityGoBlack: 1
    opacityGoBlack_internal: 0
    #goIntroductionImage heigh
    goIntroductionImageheigh:0

    #世界暂停
    pause: false
    #角度
    rot: 0

    #direction  ship 移动允许
    leftkey: false
    rightkey: false
    downkey: false
    upkey: false
    shipSpeed: 2
    #分数
    scores_num: 0 #实际分数
    scores_view: '00000' #转换为字符串的分数
    #enemy 敌人
    enemySpeed: 0 #速度
    enemyArray: []#敌机数组
    nextEnemy: 40 #下一个敌机的倒计时
    #explode 爆炸数组
    explodeArray: []


    #武器弹药系统  Weapons system
    weapons_system : false
    weapons_system_x : 810
    weapons_system_json : {"up_lv" : {"xy":[[450, 285], [450, 335], [450, 385], [615, 285], [615, 335], [615, 385]], "Whether" : [[false, 'weaponsSystemImage_button_one'],[false, 'weaponsSystemImage_button_one'],[false, 'weaponsSystemImage_button_one'],[false, 'weaponsSystemImage_button_one'],[false, 'weaponsSystemImage_button_one'],[false, 'weaponsSystemImage_button_one']]},"open" : {"xy":[[570, 290], [570, 340], [570, 390], [730, 290], [730, 340], [730, 390]], "Whether" : [[false, 'weaponsSystemImage_close'],[false, 'weaponsSystemImage_close'],[false, 'weaponsSystemImage_close'],[false, 'weaponsSystemImage_close'],[false, 'weaponsSystemImage_close'],[false, 'weaponsSystemImage_close']]}}
    #游戏失败Failure
    failure : false
    #颗粒数组
    particleArray : []
    #宝石数组
    gemsArray : []
    shieldSupplyArray : []
    gemsNum : [0,0,0,0,0,0]
    #能量＋1数组
    energyTextArray : []
    energyHint : [] # 能量不足提示按钮
    #火球 危险警告
    fireBallArray : []
    fireBallHintTime : 400
    fireBallAllow : false
    fireBallDangerHintImageAllow : false
    #boss
    bossOneDangerHintImageAllow : false
    bossOneAllow : false
    bossOneHintTime : 400
    bossOneHintSpeed : 0
    bossOneBallArray : []
    bossOneBallNum : 0
    bossOneBallTime : 0
    bossOneBallOneAllow : false
    bossOneBallTwoAllow : false
    #胜利
    victoryOne : false
    bossScores : 200  #boss的分数
    statistics : false #分数统计
    statisticsTime : 200
    lvRandomNum : 0
    lvNum : 0
    lvRandomSx : 0
    lvMidLeft :  -179 #等级中间层左半块
    lvMidRight : 825
    #游戏时间
    gameTimeIn : 0
    # 无尽模式
    EndlessMode : false

    meteorArray : [] # 流行数组












