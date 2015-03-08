game.resize = function() {
  if (window.innerHeight >= 620) {
    if (window.innerWidth >= 820) {
      game.currentHeight = 620;
      game.currentWidth = 820;
    } else {
      game.currentWidth = window.innerWidth;
      game.currentHeight = game.currentWidth / game.ratio;
    }
  } else {
    if (window.innerWidth >= 820) {
      game.currentHeight = window.innerHeight;
      game.currentWidth = game.currentHeight * game.ratio;
    } else {
      game.currentWidth = window.innerWidth;
      game.currentHeight = game.currentWidth / game.ratio;
    }
  }
  game.canvas.style.width = game.currentWidth + 'px';
  game.canvas.style.height = game.currentHeight + 'px';
  return game.scale = game.currentWidth / game.width;
};

game.Draw = {
  clear: function() {
    return game.ctx.clearRect(0, 0, game.width, game.height);
  },
  rect: function(x, y, w, h, col) {
    game.ctx.fillStyle = col;
    return game.ctx.fillRect(x, y, w, h);
  },
  circle: function(x, y, r, col) {
    game.ctx.fillStyle = col;
    game.ctx.beginPath();
    game.ctx.arc(x, y, r, 0, Math.PI * 2, true);
    game.ctx.closePath();
    return game.ctx.fill();
  },
  semiCircle: function(x, y, r, col, d) {
    game.ctx.beginPath();
    game.ctx.arc(778, 603, 32, 0, Math.PI * (1 + d), 0);
    game.ctx.strokeStyle = 'white';
    game.ctx.lineWidth = 3;
    game.ctx.stroke();
    return game.ctx.closePath();
  },
  text: function(string, x, y, size, col) {
    game.ctx.font = 'bold ' + size + 'px Monospace';
    game.ctx.fillStyle = col;
    return game.ctx.fillText(string, x, y);
  }
};

game.mousePosition = {
  x: 0,
  y: 0,
  tapped: false,
  set: function(event) {
    var _x, _y;
    _x = _y = 0;
    if (event.pageX || event.pageY) {
      _x = event.pageX;
      _y = event.pageY;
    } else {
      _x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
      _y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop;
    }
    _x -= game.canvas.offsetLeft;
    _y -= game.canvas.offsetTop;
    this.x = _x;
    this.y = _y;
    return this.tapped = true;
  }
};

window.addEventListener('load', game.init, false);

window.addEventListener('resize', game.resize, false);
