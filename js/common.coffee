"use strict"
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
    plineImgX: 0 #飞机位置
    plineImgY: 0
    music: 1


    lworld: 'begin' #世界状态
    bossOne: false  #boss允许
    win: false

    bulletTime: null #子弹时间
    bulletPower: 1 #子弹威力

    damage: 0 #损伤
    hit: 0 #命中
    ammoUse: 0 #弹药消耗
    hurt: 0 #伤害
    hitrate: 0 #命中率

    openShield: false #开启护盾
    quakeAllow: true #震动允许

    infiniteLife: false #无限生命

    whiteLine: [] #go世界状态下线条存储
    buttonArray: [] # 按钮数组
    audio: {} #声音数组


    #能量指针旋转
    energyGuidingRotate: false
    energyGuidingRotateNum : -50





