
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


game.Draw =
    clear : ->
        game.ctx.clearRect 0, 0, game.width, game.height
    rect : (x,y,w,h,col) ->
        game.ctx.fillStyle = col
        game.ctx.fillRect x,y,w,h
    circle : (x,y,r,col) ->
        game.ctx.fillStyle = col
        game.ctx.beginPath()
        game.ctx.arc x, y, r, 0, Math.PI * 2, true
        game.ctx.closePath()
        game.ctx.fill()
    semiCircle  : (x,y,r,col,d) ->
        game.ctx.beginPath()
        game.ctx.arc 778, 603, 32, 0, Math.PI * (1 + d), 0
        game.ctx.strokeStyle = 'white'
        game.ctx.lineWidth = 3
        game.ctx.stroke()
        game.ctx.closePath()
    text : (string,x,y,size,col) ->
        game.ctx.font = 'bold ' + size + 'px Monospace'
        game.ctx.fillStyle = col
        game.ctx.fillText string,x,y


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




window.addEventListener('load',game.init,false);
window.addEventListener('resize',game.resize,false);
























