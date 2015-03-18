"use strict";
game.init = function() {
  var key, ref, value;
  game.ratio = game.width / game.height;
  game.currentHeight = game.height;
  game.currentWidth = game.width;
  game.canvas = document.getElementsByTagName("canvas")[0];
  game.ctx = game.canvas.getContext("2d");
  game.canvas.width = game.width;
  game.canvas.height = game.height;
  game.resize();
  game.audioLoad([
    {
      'name': 'buttonHoverMusic',
      'audio': 'button.wav',
      'volume': 0.7
    }, {
      'name': 'beginMusic',
      'audio': 'begin2.ogg',
      'volume': 0.4,
      'cycle': true
    }
  ]);
  game.imageLoad([['targetImage', 'target.png'], ['backgroundImage_login', 'login.jpg'], ['beginImage', 'begin.png'], ['beginImage_hover', 'h_begin.png'], ['setupImage', 'shezhi.png'], ['setupImage_hover', 'h_shezhi.png'], ['helpImage', 'bangzhu.png'], ['helpImage_hover', 'h_bangzhu.png'], ['authorImage', 'zhizuo.png'], ['authorImage_hover', 'h_zhizuo.png'], ['voiceImage', 'shengyin.png'], ['voiceImage_hover', 'shengyinguanbi.png'], ['easyImage', 'jiandan.png'], ['easyImage_hover', 'jiandan1.png'], ['shookImage', 'chuangkoudoudong.png'], ['shookImage_hover', 'chuangkoudoudong1.png'], ['backImage', 'fanhui.png'], ['backImage_hover', 'fanhuiyouxi1.png']]);
  document.onmousemove = function(e) {
    var timer;
    if (game.lworld === "begin") {
      game.target.on_off = 'off';
      if (timer) {
        clearTimeout(timer);
      }
      timer = setTimeout(function() {
        return game.target.on_off = 'on';
      }, 500);
    }
  };
  game.buttonHover = function(e) {
    var i, j, ref, x, y;
    e.preventDefault();
    x = game.mouseX;
    y = game.mouseY;
    for (i = j = 0, ref = game.buttonArray.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      if (game.buttonArray[i].music === true) {
        if (game.buttonArray[i].musicNum <= 1) {
          game.audio.buttonHoverMusic.load();
          game.audio.buttonHoverMusic.play();
        }
      }
      if (x > game.buttonArray[i].x && x < game.buttonArray[i].x + game.buttonArray[i].w && y > game.buttonArray[i].y && y < game.buttonArray[i].y + game.buttonArray[i].h) {
        game.buttonArray[i].image = game[game.buttonArray[i].name + "_hover"];
        game.buttonArray[i].music = true;
        game.buttonArray[i].musicNum++;
      } else {
        game.buttonArray[i].image = game[game.buttonArray[i].name];
        game.buttonArray[i].music = false;
        game.buttonArray[i].musicNum = 0;
      }
    }
  };
  game.buttonUp = function(e) {
    var i, j, ref, results, x, y;
    e.preventDefault();
    x = game.mouseX;
    y = game.mouseY;
    results = [];
    for (i = j = 0, ref = game.buttonArray.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      if (x > game.buttonArray[i].x && x < game.buttonArray[i].x + game.buttonArray[i].w && y > game.buttonArray[i].y && y < game.buttonArray[i].y + game.buttonArray[i].h) {
        game.lworld = game.buttonArray[i].name.split('I')[0];
        if (game.lworld !== "begin") {
          window.removeEventListener('mouseup', game.buttonUp);
        } else {
          game.lworld = 'go';
        }
        if (game.lworld === 'setup') {
          game.backgroundImage_login.src = './image/shezhiyemian.jpg';
          game.buttonArray[0] = new game.button(310, 230, 177, 35, 'normal', game.voiceImage, 'voiceImage');
          game.buttonArray[1] = new game.button(310, 285, 177, 35, 'normal', game.easyImage, 'easyImage');
          game.buttonArray[2] = new game.button(310, 335, 177, 35, 'normal', game.shookImage, 'shookImage');
          results.push(game.buttonArray[3] = new game.button(310, 390, 177, 35, 'normal', game.backImage, 'backImage'));
        } else {
          results.push(void 0);
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  };
  ref = game.audio;
  for (key in ref) {
    value = ref[key];
    game.audio[key].volume = game.audio[key].volume_rem;
  }
  window.addEventListener('mousemove', function(e) {
    game.mousePosition.set(e);
    game.mouseX = game.mousePosition.x / game.scale;
    game.mouseY = game.mousePosition.y / game.scale;
  });
  window.addEventListener('mousemove', game.buttonHover);
  window.addEventListener("mouseup", game.buttonUp);
  game.buttonArray[0] = new game.button(565, 285, 172, 55, 'normal', game.beginImage, 'beginImage');
  game.buttonArray[1] = new game.button(585, 350, 123, 39, 'normal', game.setupImage, 'setupImage');
  game.buttonArray[2] = new game.button(585, 400, 123, 39, 'normal', game.helpImage, 'helpImage');
  game.buttonArray[3] = new game.button(585, 450, 123, 39, 'normal', game.authorImage, 'authorImage');
  game.target = new game.targetFn(game.mouseX, game.mouseY);
  return game.loop();
};
