"use strict"
# 这是循环函数
game.loop = ->
    window.requestAnimationFrame game.loop
    game.update()
    game.render()