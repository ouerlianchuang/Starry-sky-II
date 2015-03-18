"use strict";
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
  game.scale = game.currentWidth / game.width;
};

game.Draw = {
  clear: function() {
    game.ctx.clearRect(0, 0, game.width, game.height);
  },
  rect: function(x, y, w, h, col) {
    game.ctx.fillStyle = col;
    game.ctx.fillRect(x, y, w, h);
  },
  circle: function(x, y, r, col) {
    game.ctx.fillStyle = col;
    game.ctx.beginPath();
    game.ctx.arc(x, y, r, 0, Math.PI * 2, true);
    game.ctx.closePath();
    game.ctx.fill();
  },
  semiCircle: function(x, y, r, col, d) {
    game.ctx.beginPath();
    game.ctx.arc(778, 603, 32, 0, Math.PI * (1 + d), 0);
    game.ctx.strokeStyle = 'white';
    game.ctx.lineWidth = 3;
    game.ctx.stroke();
    game.ctx.closePath();
  },
  text: function(string, x, y, size, col) {
    game.ctx.font = 'bold ' + size + 'px Monospace';
    game.ctx.fillStyle = col;
    game.ctx.fillText(string, x, y);
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
    this.tapped = true;
  }
};

game.targetFn = function(x, y) {
  this.x = x;
  this.y = y;
  this.sx = 0;
  this.n = 0;
  this.rot = 0;
  this.spin = false;
  this.on_off = 'on';
  this.update = function() {
    this.n++;
    if (this.on_off === 'on') {
      this.rot += 0.1;
      if (this.rot > 50) {
        this.spin = true;
      }
      if (this.spin) {
        this.rot -= 0.3;
        if (this.rot < 35) {
          this.spin = false;
          this.rot = 0;
        }
      }
    }
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(this.rot % 360) * Math.PI / 180;
    game.ctx.drawImage(game.targetImage, 0, 0, 25, 24, -12.5, -12, 25, 24);
    game.ctx.restore();
  };
};

game.imageLoad = function(array) {
  var ImageName, i, j, name, ref;
  for (i = j = 0, ref = array.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    name = array[i][0];
    ImageName = array[i][1];
    game[name] = new Image();
    game[name].src = "./image/" + ImageName;
    game[name].onload = function() {};
    game[name].onerror = function() {
      console.log(name + "图片加载错误");
    };
  }
};

game.audioLoad = function(array) {
  var i, j, my_audio, my_cycle, my_name, my_volume, ref;
  for (i = j = 0, ref = array.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    my_name = array[i]['name'];
    my_audio = array[i]['audio'];
    my_volume = array[i]['volume'] || 0.4;
    my_cycle = array[i]['cycle'] || false;
    game.audio[my_name] = new Audio();
    game.audio[my_name].src = "./music/" + my_audio;
    game.audio[my_name].volume = my_volume;
    game.audio[my_name].volume_rem = my_volume;
    if (my_cycle) {
      game.audio[my_name].addEventListener("ended", function() {
        this.currentTime = 0;
        this.load();
        return this.play();
      }, false);
    }
  }
};

game.button = function(x, y, w, h, state, image, name) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.state = state;
  this.image = image;
  this.name = name;
  this.music = false;
  this.musicNum = 0;
};

window.addEventListener('load', game.init, false);

window.addEventListener('resize', game.resize, false);
