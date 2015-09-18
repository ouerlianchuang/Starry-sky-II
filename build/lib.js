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

game.drawFrame = function() {
  game.ctx.drawImage(game.energyTankDownImage, 0, 0);
  game.ctx.drawImage(game.energyTankImage, 0, 0, 200, 31, 635, 590, 200, 31);
  game.ctx.drawImage(game.energyTankUpImage, 0, 0);
  game.ctx.drawImage(game.energyStationImage, 720, 548);
  game.Draw.semiCircle(100, 100, 50, 'red', game.energyValue / 800);
  if (game.energyGuidingRotate === false) {
    game.energyGuidingRotateNum += 2;
  } else {
    game.energyGuidingRotateNum -= 2;
  }
  if (game.energyGuidingRotateNum >= 50) {
    game.energyGuidingRotate = true;
  }
  if (game.energyGuidingRotateNum <= -50) {
    game.energyGuidingRotate = false;
  }
  game.ctx.save();
  game.ctx.translate(781, 608);
  game.ctx.rotate(game.energyGuidingRotateNum % 360 * Math.PI / 180);
  game.ctx.drawImage(game.energyGuidingImage, 0, 0, 16, 40, -8, -40, 16, 40);
  game.ctx.restore();
  game.ctx.drawImage(game.gameFrameImage, 0, 0, 820, 620, 0, 0, 820, 620);
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
    game.audio[my_name].volume_allow = true;
    if (my_cycle) {
      game.audio[my_name].addEventListener("ended", function() {
        this.currentTime = 0;
        this.load();
        return this.play();
      }, false);
    }
  }
};

game.audioVolumeswitch = function(key) {
  var ref, ref1, results, results1, value;
  if (key === 'on') {
    ref = game.audio;
    results = [];
    for (key in ref) {
      value = ref[key];
      game.audio[key].volume = game.audio[key].volume_rem;
      results.push(game.audio[key].volume_allow = true);
    }
    return results;
  } else {
    ref1 = game.audio;
    results1 = [];
    for (key in ref1) {
      value = ref1[key];
      game.audio[key].volume = 0;
      results1.push(game.audio[key].volume_allow = false);
    }
    return results1;
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

game.line = function() {
  this.type = 'go';
  this.x = 0;
  this.y = parseInt(Math.random() * 620);
  this.r = parseInt(Math.random() * 1.5);
  this.opacity = 1;
  this.fade = 0.05;
  this.remove = false;
  this.update = function() {
    this.opacity -= this.fade;
    this.remove = this.opacity < 0 ? true : false;
  };
  this.render = function() {
    game.Draw.rect(this.x, this.y, 820, this.r, 'rgba(82,139,139,' + this.opacity + ')');
  };
};

game.hero = function(x, y, w, h, shield) {
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.shield = shield;
  this.imageShift = 40;
  this.rotation = 0;
  this.sx = 0;
  this.rotate = 0;
  this.update = function() {
    if (this.shield === 'shield_one') {
      if (this.rotate % 3 === 0) {
        this.sx += 115;
      }
      this.rotate++;
      if (this.sx >= 690) {
        this.sx = 0;
      }
    }
    if (this.shield === 'shield_two') {
      if (this.rotate % 7 === 0) {
        this.sx += 86;
      }
      this.rotate++;
      if (this.sx >= 344) {
        this.sx = 0;
      }
    }
    if (this.shield === 'initial') {
      this.sx = 0;
    }
  };
};

game.hero.prototype.Draw = function(ctx, rot) {
  this.rotation = rot;
  ctx.save();
  if (this.shield === 'initial' || this.shield === 'radar') {
    this.image = game.heroImage;
  }
  if (this.shield === 'shield_one') {
    this.image = game.heroImage_shield_one;
  }
  if (this.shield === 'shield_two') {
    this.image = game.heroImage_shield_two;
  }
  ctx.translate(this.x, this.y);
  ctx.rotate(this.rotation);
  if (this.shield === 'shield_one') {
    this.w = 115;
    this.h = 115;
    ctx.drawImage(this.image, this.sx, 0, 115, 115, -115 / 2, -115 / 2, 115, 115);
  } else if (this.shield === 'shield_two') {
    this.w = 86;
    this.h = 115;
    ctx.drawImage(this.image, this.sx, 0, 86, 115, -86 / 2, -115 / 2, 86, 115);
  } else {
    if (this.shield === 'radar') {
      this.w = 66;
      this.h = 66;
    } else {
      this.w = 66;
      this.h = 66;
    }
    ctx.drawImage(this.image, -66 / 2, -66 / 2, 66, 66);
  }
  ctx.restore();
};

game.flame = function() {
  this.sx = 0;
  this.num = 0;
  this.update = function() {
    this.num++;
    this.x = game.shipImgX;
    this.y = game.shipImgY;
    if (this.num % 2 === 0) {
      this.sx += 40;
    }
    if (this.sx > 320) {
      this.sx = 0;
    }
  };
  this.render = function(rot) {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(rot);
    game.ctx.drawImage(game.flameImage, this.sx, 0, 40, 40, -30, -20.5, 40, 40);
    game.ctx.restore();
  };
};

game.scores = function(num) {
  var i, j, ref;
  if (game.scores_num < 1000000 && game.scores_num >= 100000) {
    game.scores_view = '' + game.scores_num;
  } else if (game.scores < 100000 && game.scores_num >= 10000) {
    game.scores_view = '0' + game.scores_num;
  } else if (game.scores_num < 10000 && game.scores_num >= 1000) {
    game.scores_view = '00' + game.scores_num;
  } else if (game.scores_num < 1000 && game.scores_num >= 100) {
    game.scores_view = '000' + game.scores_num;
  } else if (game.scores_num < 100 && game.scores_num >= 10) {
    game.scores_view = '0000' + game.scores_num;
  } else if (game.scores_num < 10) {
    game.scores_view = '00000' + game.scores_num;
  }
  for (i = j = 0, ref = game.scores_view.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    game.ctx.drawImage(game.scoresImage, 0 + 17 * game.scores_view.charAt(i), 0, 17, 25, 35 + 17 * i, 29, 17, 25);
  }
};

game.energyText = function(x, y) {
  this.x = x;
  this.y = y;
  this.remove = false;
  this.size = 0.1;
  this.dir = Math.random() * 2 > 1 ? 1 : -1;
  this.vx = Math.random() * 4 * this.dir;
  this.vy = Math.random() * 7;
  this.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.vx *= 0.99;
    this.vy *= 0.99;
    this.vy -= 0.1;
    if (this.y < 0) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.Draw.text("能量＋1", this.x, this.y, 1, "rgba(47,79,79,1)");
  };
};

game.particle = function(x, y, r) {
  this.x = x;
  this.y = y;
  this.r = Math.random() * 2.5 + 0.5;
  this.dir = Math.random() * 2 > 1 ? 1 : -1;
  this.vx = Math.random() * 4 * this.dir;
  this.vy = Math.random() * 7;
  this.colRandomR = Math.round(Math.random() * 255);
  this.colRandomG = Math.round(Math.random() * 255);
  this.colRandomB = Math.round(Math.random() * 255);
  this.col = "rgba(255,255,255," + (Math.random()) + ")";
  this.remove = false;
  this.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.vx *= 0.99;
    this.vy *= 0.99;
    this.vy -= 0.15;
    if (this.y < 0) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.Draw.circle(this.x, this.y, this.r, this.col);
  };
};

game.gems = function(x, y, sx, sy) {
  this.w = 25;
  this.h = 25;
  this.dx = x - sx;
  this.dy = y - sy;
  this.rad = Math.atan2(this.dy, this.dx);
  this.x = x;
  this.y = y;
  this.rot = Math.floor(Math.random() * 180);
  this.dir = Math.random() * 2 > 1 ? 1 : -1;
  this.vx = Math.random() * 4 * this.dir;
  this.vy = Math.random() * 7;
  this.remove = false;
  this.random = Math.round(Math.random() * 5);
  this.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.vx *= 0.99;
    this.vy *= 0.99;
    this.x -= Math.cos(this.rad) * 6;
    this.y -= Math.sin(this.rad) * 6;
    if (this.y < 0 || this.y > 620 || this.x < 0 || this.x > 820) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    this.rot += this.random;
    game.ctx.rotate(this.rot % 360 * Math.PI / 180);
    game.ctx.drawImage(game.gemsImage, 0 + 25 * this.random, 0, this.w, this.h, -25 / 2, -25 / 2, 25, 25);
    game.ctx.restore();
  };
};

game.enemy = function(enemy) {
  this.type = enemy;
  this.random = 0;
  if (this.type === 'one') {
    this.image = game.enemyImage_one;
    this.w = 103;
    this.h = 59;
    this.x = Math.random() * game.width;
    this.y = game.height;
    this.constant = this.x;
    this.life = 5;
  } else if (this.type === 'lv2seven') {
    this.image = game.enemyImage_seven_lv2;
    this.w = 164;
    this.h = 97;
    this.x = Math.random() * game.width;
    this.y = game.height;
    this.constant = this.x;
    this.life = 25;
  } else if (this.type === 'lv2eight') {
    if (Math.random() * 4 < 1) {
      this.random = 6;
    }
    this.image = game.enemyImage_eight_lv2;
    this.w = 118;
    this.h = 103;
    this.x = Math.random() * game.width;
    this.y = game.height;
    this.constant = this.x;
    this.life = 25;
  } else if (this.type === 'two') {
    this.image = game.enemyImage_two;
    this.w = 59;
    this.h = 103;
    this.x = game.width;
    this.y = Math.random() * game.height;
    this.constant = this.y;
    this.life = 5;
  } else if (this.type === 'lv2one') {
    if (Math.random() * 4 < 1) {
      this.random = 5;
    }
    this.image = game.enemyImage_one_lv2;
    this.w = 205;
    this.h = 132;
    this.x = game.width;
    this.y = Math.random() * (game.height - 50);
    this.constant = this.y;
    this.life = 20;
  } else if (this.type === 'lv2four') {
    if (Math.random() * 2 < 1) {
      this.random = 5;
    }
    this.image = game.enemyImage_four_lv2;
    this.w = 266;
    this.h = 86;
    this.x = game.width;
    this.y = Math.random() * (game.height - 50);
    this.constant = this.y;
    this.life = 25;
  } else if (this.type === 'lv2five') {
    if (Math.random() * 3 < 1) {
      this.random = 5;
    }
    this.image = game.enemyImage_five_lv2;
    this.w = 277;
    this.h = 82;
    this.x = game.width;
    this.y = Math.random() * (game.height - 50);
    this.constant = this.y;
    this.life = 25;
  } else if (this.type === 'lv2two') {
    this.image = game.enemyImage_two_lv2;
    this.w = 232;
    this.h = 144;
    this.x = game.width;
    this.y = Math.random() * (game.height - 50);
    this.constant = this.y;
    this.life = 20;
    if (Math.random() * 4 < 1) {
      this.random = 5;
      this.image = game.enemyImage_three_lv2;
      this.w = 239;
      this.h = 60;
    }
  }
  this.r = Math.random() * 25 + 5;
  this.speedScope = Math.random() * 3 + 1;
  this.speed = game.enemySpeed + this.speedScope + this.random;
  this.waveSize = 60;
  this.remove = false;
  this.update = function() {
    var time;
    time = new Date().getTime() * 0.002;
    if (this.type === 'one' || this.type === 'lv2seven' || this.type === 'lv2eight') {
      this.y -= this.speed;
      this.x = this.waveSize * Math.sin(time) + this.constant;
    } else if (this.type === 'two' || this.type === 'lv2one' || this.type === 'lv2two' || this.type === 'lv2three' || this.type === 'lv2four' || this.type === 'lv2five') {
      this.x -= this.speed;
      this.y = this.waveSize * Math.sin(time) + this.constant;
    }
    if (this.life <= 0) {
      this.remove = true;
    }
    if (this.type === 'one' && this.y < -10) {
      this.remove = true;
    }
    if (this.type === 'two' && this.x < -10) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(this.image, this.x, this.y);
  };
};

game.hint = function(x, y) {
  this.x = x;
  this.y = y;
  this.opa = 1;
  this.remove = false;
  this.update = function() {
    this.y -= 2;
    this.opa -= 0.05;
    if (this.x <= 0 || this.opa <= 0) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.Draw.text('能量不足..', this.x, this.y, 1, "rgba(255,255,255," + this.opa + ")");
  };
};

game.shieldSupply = function(x, y) {
  this.x = x;
  this.y = y;
  this.dir = Math.random() * 2 > 1 ? 1 : -1;
  this.vx = Math.random() * 4 * this.dir;
  this.vy = Math.random() * 7;
  this.remove = false;
  this.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.vx *= 0.99;
    this.vy *= 0.99;
    this.vy -= 0.25;
    if (this.y < 0) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(game.shieldSupplyImage, this.x, this.y);
  };
};

game.explode = function(x, y) {
  this.x = x;
  this.y = y;
  this.sx = 0;
  this.num = 0;
  this.update = function() {
    this.num++;
    if (this.num % 4 === 0) {
      this.sx += 120;
    }
    if (this.sx > 1080) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(game.explodeImage, this.sx, 0, 120, 120, this.x, this.y, 120, 120);
  };
};

game.collide = function(objA, objB, revolve) {
  if (revolve) {
    if (objA.x > objB.x - objB.w / 2 && objA.x < objB.x - objB.w / 2 + objB.w && objA.y < objB.y - objB.h / 2 + objB.h && objA.y > objB.y - objB.h / 2) {
      return true;
    }
  } else {
    if (objA.x > objB.x && objA.x < objB.x + objB.w && objA.y < objB.y + objB.h && objA.y > objB.y) {
      return true;
    }
  }
  return false;
};

game.bullet = function(sx, sy, rot, g, t, img) {
  this.x = sx;
  this.y = sy;
  this.bg = g;
  this.bt = t;
  this.brot = rot;
  this.bimg = img;
  this.remove = false;
  this.update = function() {
    this.x += Math.cos(this.brot) * 15;
    this.y += Math.sin(this.brot) * 15;
    this.remove = this.x < 0 || this.x > 820 || this.y < 0 || this.y > 620 ? true : false;
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(this.brot);
    game.ctx.drawImage(this.bimg, this.bg, this.bt);
    game.ctx.restore();
  };
};

game.fireBall = function() {
  this.x = 830;
  this.w = 100;
  this.h = 69;
  this.y = Math.round(Math.random() * 600 + 10);
  this.speed = 5;
  this.num = 0;
  this.sx = 0;
  this.life = 8;
  this.remove = false;
  this.update = function() {
    this.num++;
    this.x -= this.speed;
    if (this.num % 4 === 0) {
      this.sx += 100;
      if (this.sx === 700) {
        this.sx = 0;
      }
    }
    if (this.x < -10) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(game.fireBallImage, this.sx, 0, 100, 69, this.x, this.y, 100, 69);
  };
};

game.boss = function() {
  this.x = 850;
  this.w = 215;
  this.h = 245;
  this.y = 300;
  this.life = 20000;
  this.speed = 0.2;
  this.jiaodu = -90;
  this.sss = 0;
  this.zhuan = false;
  this.sx = 880;
  this.time = 0;
  this.h = 245;
  this.ai = 'begin';
  this.up = true;
  this.down = false;
  this.ballone = false;
  this.balltwo = false;
  this.xunhuanjiguang = 1;
  this.zidanthree = false;
  this.zidanfour = false;
  this.zidancishu = 0;
  this.update = function() {
    if (this.life > 0) {
      if (this.x === 600) {
        this.ai = 'go';
      }
      if (this.ai === 'begin') {
        this.x--;
      }
      if (this.ai === 'go') {
        this.ballone = true;
        this.time++;
        if (this.time >= 100) {
          this.x++;
        }
        if (this.x >= 650) {
          this.ai = 'goupdown';
        }
      }
      if (this.ai === 'goupdown') {
        this.time++;
        if (this.time >= 100) {
          if (this.up) {
            if (this.time % 10 === 0) {
              this.sx += 220;
            }
            if (this.sx >= 1760) {
              this.sx = 1760;
            }
            this.y -= 0.5;
            if (this.y <= 100) {
              this.xunhuanjiguang++;
              this.up = false;
              this.down = true;
            }
          }
          if (this.down) {
            if (this.time % 10 === 0) {
              this.sx -= 220;
            }
            if (this.sx <= 0) {
              this.sx = 0;
            }
            this.y += 0.5;
            if (this.y >= 500) {
              this.xunhuanjiguang++;
              this.up = true;
              this.down = false;
            }
          }
        }
      }
      if (this.ballone) {
        if (this.xunhuanjiguang % 2 === 0) {
          game.jiguangpao.sx = 0;
          this.balltwo = true;
          this.ballone = false;
          this.xunhuanjiguang = 1;
        }
      }
      if (this.balltwo) {
        if (this.xunhuanjiguang % 2 === 0) {
          game.jiguangpao.sx = 0;
          this.balltwo = false;
          this.ballone = true;
          this.xunhuanjiguang = 1;
        }
      }
    }
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(this.jiaodu * Math.PI / 180);
    game.ctx.drawImage(game.bossImage, this.sx, 0, 215, 245, -110, -122.5, 215, 245);
    game.ctx.restore();
  };
};

game.jiguang = function() {
  this.x = 700;
  this.y = 0;
  this.sx = 0;
  this.update = function() {
    this.y = game.bossOne.y;
    this.sx += 5;
    if (this.sx >= 820) {
      this.sx = 820;
    }
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(90 * Math.PI / 180);
    game.ctx.drawImage(game.bossjiguangImage, 0, 0, 67, this.sx, -30, 0, 67, this.sx);
    game.ctx.restore();
  };
};

game.bossBall = function(x, y, t) {
  this.x = x;
  this.y = y;
  this.w = 50;
  this.h = 50;
  this.t = t;
  this.remove = false;
  this.update = function() {
    this.x -= 3;
    this.y = this.y - this.t;
    if (this.x <= -10) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(game.bossBallImage, 0, 0, 50, 50, this.x, this.y, 50, 50);
  };
};

game.bossBallTwo = function(x, y, r) {
  this.x = x;
  this.y = y;
  this.rad = r;
  this.w = 20;
  this.h = 21;
  this.remove = false;
  this.update = function() {
    this.x += Math.cos(this.rad) * 5;
    this.y += Math.sin(this.rad) * 5;
    if (this.x <= -10) {
      this.remove = true;
    }
    if (this.x >= 830) {
      this.remove = true;
    }
    if (this.y <= -10) {
      this.remove = true;
    }
    if (this.y >= 630) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.save();
    game.ctx.translate(this.x, this.y);
    game.ctx.rotate(this.rad * Math.PI / 180);
    game.ctx.drawImage(game.bossBallImage_two, 0, 0, 20, 21, -10, -10.5, 20, 21);
    game.ctx.restore();
  };
};

game.gemsScores = function(x, y, t) {
  this.t = t;
  this.x = x;
  this.y = y;
  this.dir = Math.random() * 2 > 1 ? 1 : -1;
  this.vx = Math.random() * 4 * this.dir;
  this.vy = Math.random() * 7;
  this.remove = false;
  this.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.vx *= 0.99;
    this.vy *= 0.99;
    this.vy -= 0.25;
    if (this.y < 0) {
      this.remove = true;
    }
  };
  this.render = function() {
    game.ctx.drawImage(game.gemsScoresImage, 0 + 160 * this.t, 0, 160, 30, this.x, this.y, 160, 30);
  };
};

game.sp = function(x, y, num) {};

game.meteor = function(x, y, opa, r, speed, col) {
  this.x = x;
  this.y = y;
  this.opa = opa;
  this.r = r;
  this.speed = speed;
  this.remove = false;
  this.update = function() {
    this.x -= this.speed;
    if (this.x < -10) {
      this.remove = true;
    }
  };
  this.render = function() {
    if (col === 'red') {
      game.Draw.circle(this.x, this.y, this.r, "rgba(252,48,57," + this.opa + ")");
    } else {
      game.Draw.circle(this.x, this.y, this.r, "rgba(255,255,255," + this.opa + ")");
    }
  };
};

window.addEventListener('load', game.init, false);

window.addEventListener('resize', game.resize, false);
