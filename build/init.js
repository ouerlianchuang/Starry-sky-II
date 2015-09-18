"use strict";
game.init = function() {
  var j, k, l, m, n, o, p, q, r, s;
  game.lworld = "begin";
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
      'volume': 0.3
    }, {
      'name': 'beginMusic',
      'audio': 'begin2.ogg',
      'volume': 0.1,
      'cycle': true
    }, {
      'name': 'warMusic',
      'audio': '吴欣睿 - 临危.mp3',
      'volume': 0.1,
      'cycle': true
    }, {
      'name': 'middleMusic',
      'audio': 'guochang.mp3',
      'volume': 0.1,
      'cycle': true
    }, {
      'name': 'bullteMusic',
      'audio': 'zidanmusic1.wav',
      'volume': 0.1,
      'cycle': true
    }, {
      'name': 'explodeMusic',
      'audio': 'baozhamusic.mp3',
      'volume': 0.5
    }, {
      'name': 'weaponssSystemMusic',
      'audio': 'wuqixitongdakai.wav',
      'volue': 1
    }, {
      'name': 'lvCollideMusic',
      'audio': 'lvzhuangji.wav',
      'volue': 1
    }
  ]);
  game.imageLoad([['targetImage', 'target.png'], ['backgroundImage', 'login.jpg'], ['backgroundImage_help', 'bangzhu.jpg'], ['beginImage', 'begin.png'], ['beginImage_hover', 'h_begin.png'], ['setupImage', 'shezhi.png'], ['setupImage_hover', 'h_shezhi.png'], ['helpImage', 'bangzhu.png'], ['helpImage_hover', 'h_bangzhu.png'], ['authorImage', 'zhizuo.png'], ['authorImage_hover', 'h_zhizuo.png'], ['voiceImage', 'shengyin.png'], ['voiceOffImage', 'shenyinguanbi.png'], ['voiceImage_hover', 'shengyinkaiqihover.png'], ['voiceOffImage_hover', 'shengyinguanbi.png'], ['easyImage', 'jiandan.png'], ['easyImage_hover', 'jiandan1.png'], ['shookImage', 'chuangkoudoudong.png'], ['shookImage_hover', 'chuangkoudoudong1.png'], ['backImage', 'fanhui.png'], ['backImage_hover', 'fanhuiyouxi1.png'], ['backInImage', 'fanhuicaidan.png'], ['backInImage_hover', 'fanhuicaidan.png'], ['setup_window', 'tanchuang2.png'], ['backgroundImage_go', 'backg.jpg'], ['gameFrameImage', 'backg2.png'], ['energyTankUpImage', 'nengliangcaoshang.png'], ['energyTankDownImage', 'nengliangcaoxia.png'], ['energyTankImage', 'nengliangtiao.png'], ['energyGuidingImage', 'nengliangzhizhen.png'], ['energyStationImage', 'nengliangpan.png'], ['goBeginImage', 'b.png'], ['goBeginImage_hover', 'b2.png'], ['goIntroductionImage', 'gojieshao.png'], ['heroImage', 'self5.png'], ['heroImage_shield_one', 'feiji.png'], ['heroImage_shield_two', 'hudun.png'], ['flameImage', 'weiyan.png'], ['scoresImage', 'fenshuimg.png'], ['enemyImage_one', 'diren1.png'], ['enemyImage_two', 'diren2.png'], ['explodeImage', 'baozha.png'], ['bulletImage_one', '/bullet/1.png'], ['bulletImage_two', '/bullet/2.png'], ['bulletImage_three', '/bullet/1a.png'], ['bulletImage_four', '/bullet/2a.png'], ['bulletImage_five', '/bullet/1c.png'], ['bulletImage_six', '/bullet/4.png'], ['bulletImage_seven', '/bullet/222.png'], ['weaponsSystemImage_frame', 'wuqixitong.png'], ['weaponsSystemImage_button_one', 'qianghuaanniu1.png'], ['weaponsSystemImage_button_two', 'qianghuaanniu2.png'], ['weaponsSystemImage_open', 'qiyong2.png'], ['weaponsSystemImage_close', 'qiyong1.png'], ['pasuseImage', 'zanting.png'], ['bloodGrooveImage_bottom', 'xuecaodi1.png'], ['bloodGrooveImage_bottom_danger', 'xuecaodi2.png'], ['bloodGrooveImage_hp', 'xuetiao1.png'], ['bloodGrooveImage_hp_danger', 'xuetiao2.png'], ['bloodGrooveImage_frame', 'xuecao1.png'], ['bloodGrooveImage_frame_danger', 'xuecao2.png'], ['dangerImage', 'weixianzhuangtai.png'], ['gemsImage', 'baoshi.png'], ['gemsScoresImage', 'jiafen.png'], ['failureImage', 'shibai.png'], ['fireBallDangerHintImage', 'jinggao.png'], ['fireBallImage', 'huoqiu.png'], ['bossDangerHintImage_bottom', 'weixianjinggaodibu.png'], ['bossDangerHintImage_frame', 'weixianjinggao.png'], ['bossDangerHintImage_text', 'weixianjinggaozi.png'], ['bossDangerHintImage_bk', 'bossxuese.png'], ['bossImage', 'boss1.png'], ['bossBallImage', '/bullet/boss1.png'], ['bossBallImage_two', '/bullet/13.png'], ['bossjiguangImage', '/bullet/14.png'], ['shieldSupplyImage', 'hudunbuji.png'], ['lvImage_bottom', 'dengji-pi.png'], ['lvImage_mid', 'dengji-di.png'], ['lvImage_lv', 'dengji.png'], ['backImage_die', 'fanhuicaidan.png'], ['ContinueChallengeImage', 'jixutiaozhan.png'], ['enemyImage_one_lv2', '/lv2/1.png'], ['enemyImage_two_lv2', '/lv2/2.png'], ['enemyImage_three_lv2', '/lv2/3.png'], ['enemyImage_four_lv2', '/lv2/4.png'], ['enemyImage_five_lv2', '/lv2/8.png'], ['enemyImage_six_lv2', '/lv2/10.png'], ['enemyImage_seven_lv2', '/lv2/Mech1A.png'], ['enemyImage_eight_lv2', '/lv2/Mech3.png'], ['enemyImage_nine_lv2', '/lv2/Mech4.png']]);
  game.begin_button = [new game.button(565, 285, 172, 55, 'normal', game.beginImage, 'beginImage'), new game.button(585, 350, 123, 39, 'normal', game.setupImage, 'setupImage'), new game.button(585, 400, 123, 39, 'normal', game.helpImage, 'helpImage'), new game.button(585, 450, 123, 39, 'normal', game.authorImage, 'authorImage')];
  game.setup_button = [new game.button(310, 230, 177, 35, 'normal', game.voiceImage, 'voiceImage'), new game.button(310, 285, 177, 35, 'normal', game.easyImage, 'easyImage'), new game.button(310, 335, 177, 35, 'normal', game.shookImage, 'shookImage'), new game.button(310, 390, 177, 35, 'normal', game.backImage, 'backImage')];
  game.help_button = [new game.button(600, 540, 177, 35, 'normal', game.backInImage, 'backInImage')];
  game.author_button = [new game.button(600, 540, 177, 35, 'normal', game.backInImage, 'backInImage')];
  game.go_button = [new game.button(364, 405, 73, 24, 'normal', game.goBeginImage, 'goBeginImage')];
  document.onmousemove = function(e) {
    var timer;
    game.target.on_off = 'off';
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(function() {
      return game.target.on_off = 'on';
    }, 500);
  };
  game.buttonHover_begin = function(e) {
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
  game.buttonUp_go = function(e) {
    var x, y;
    e.preventDefault();
    x = game.mouseX;
    y = game.mouseY;
    if (x > 364 && x < 437 && y > 405 && y < 429) {
      if (game.opacityGoBlack <= 0) {
        game.lworld = "gogo";
        game.gameTime = new Date().getTime();
        game.audio.middleMusic.load();
        game.audio.beginMusic.load();
        game.audio.warMusic.play();
        window.removeEventListener('mousemove', game.buttonHover_begin);
        window.removeEventListener('mouseup', game.buttonUp_go);
        window.addEventListener('keydown', game.directionKeyDown);
        return window.addEventListener('keyup', game.directionKeyUp);
      }
    }
  };
  game.buttonUp_begin = function(e) {
    var i, j, ref, x, y;
    e.preventDefault();
    x = game.mouseX;
    y = game.mouseY;
    for (i = j = 0, ref = game.buttonArray.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      if (x > game.buttonArray[i].x && x < game.buttonArray[i].x + game.buttonArray[i].w && y > game.buttonArray[i].y && y < game.buttonArray[i].y + game.buttonArray[i].h) {
        game.lworld = game.buttonArray[i].name.split('I')[0];
        if (game.lworld !== "begin") {
          window.removeEventListener('mouseup', game.buttonUp_begin);
        } else {
          game.lworld = "go";
          game.backgroundImage.src = './image/backg.jpg';
          if (game.audio.beginMusic.volume_allow) {
            game.audio.beginMusic.volume = 0.2;
          }
          game.audio.middleMusic.play();
          window.removeEventListener('mouseup', game.buttonUp_begin);
          window.addEventListener('mouseup', game.buttonUp_go);
          game.buttonArray = game.go_button;
        }
        if (game.lworld === 'setup') {
          window.addEventListener('mouseup', game.buttonUp_setup);
          game.backgroundImage.src = './image/shezhiyemian.jpg';
          game.buttonArray = game.setup_button;
        }
        if (game.lworld === 'help') {
          window.addEventListener('mouseup', game.buttonUp_setup);
          game.backgroundImage.src = './image/bangzhu.jpg';
          game.buttonArray = game.help_button;
        }
        if (game.lworld === 'author') {
          window.addEventListener('mouseup', game.buttonUp_setup);
          game.backgroundImage.src = './image/tuandui.jpg';
          game.buttonArray = game.author_button;
        }
      }
    }
  };
  game.buttonUp_setup = function(e) {
    var i, j, ref, x, y;
    e.preventDefault();
    x = game.mouseX;
    y = game.mouseY;
    for (i = j = 0, ref = game.buttonArray.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
      if (x > game.buttonArray[i].x && x < game.buttonArray[i].x + game.buttonArray[i].w && y > game.buttonArray[i].y && y < game.buttonArray[i].y + game.buttonArray[i].h) {
        if (game.buttonArray[i].name.split('I')[0] === "back") {
          window.removeEventListener('mouseup', game.buttonUp_setup);
          window.addEventListener('mouseup', game.buttonUp_begin);
          game.lworld = 'begin';
          game.backgroundImage.src = './image/login.jpg';
          game.buttonArray = game.begin_button;
        }
      }
    }
  };
  game.directionKeyDown = function(e) {
    if (game.lworld === "gogo") {
      switch (e.keyCode) {
        case 87:
          return game.upkey = true;
        case 83:
          return game.downkey = true;
        case 65:
          return game.leftkey = true;
        case 68:
          return game.rightkey = true;
      }
    }
  };
  game.directionKeyUp = function(e) {
    if (game.lworld === "gogo") {
      switch (e.keyCode) {
        case 87:
          return game.upkey = false;
        case 83:
          return game.downkey = false;
        case 65:
          return game.leftkey = false;
        case 68:
          return game.rightkey = false;
        case 82:
          if (game.weapons_system) {
            game.weapons_system = false;
            game.weapons_system_x = 820;
          } else {
            game.weapons_system = true;
          }
          if (game.weapons_system) {
            game.audio.weaponssSystemMusic.load();
            return game.audio.weaponssSystemMusic.play();
          }
          break;
      }
    }
  };
  game.bulletGo = function(x, y) {
    var rr;
    game.bulletTime++;
    game.audio.bullteMusic.play();
    switch (game.bulletStyle) {
      case 1:
        if (game.bulletTime % 5 === 0) {
          game.bulletPower = 1;
          game.ammoUse++;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, game.rot, -12.5, -6, game.bulletImage_one));
        }
        break;
      case 2:
        if (game.bulletTime % 3 === 0) {
          game.ammoUse++;
          game.bulletPower = 1;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY + 5, game.rot, -9, -4, game.bulletImage_two));
        }
        break;
      case 3:
        if (game.bulletTime % 2 === 0) {
          game.ammoUse++;
          game.bulletPower = 1;
          rr = game.rot + (Math.random() * 0.5 - 0.27);
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, rr, -20, -10, game.bulletImage_three));
        }
        break;
      case 4:
        if (game.bulletTime % 2 === 0) {
          game.ammoUse++;
          game.bulletPower = 2;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, game.rot, -12.5, -7.5, game.bulletImage_four));
        }
        break;
      case 5:
        if (game.bulletTime % 4 === 0) {
          game.ammoUse++;
          game.bulletPower = 3;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, game.rot, -24.5, -30, game.bulletImage_five));
        }
        break;
      case 6:
        if (game.bulletTime % 2 === 0) {
          game.ammoUse++;
          game.bulletPower = 3;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, game.rot, -20, -7.5, game.bulletImage_six));
        }
        break;
      case 7:
        if (game.bulletTime % 8 === 0) {
          game.ammoUse++;
          game.bulletPower = 3;
          game.bulletArray.push(new game.bullet(game.shipImgX, game.shipImgY, game.rot, -20, -8, game.bulletImage_seven));
        }
    }
    game.bulletAllow = window.requestAnimationFrame(game.bulletGo);
  };
  document.onmouseup = function(e) {
    var a, j, ref;
    if (game.lworld === 'setup') {
      if (game.mouseX > game.setup_button[0].x && game.mouseX < game.setup_button[0].x + game.setup_button[0].w && game.mouseY > game.setup_button[0].y && game.mouseY < game.setup_button[0].y + game.setup_button[0].h) {
        if (game.audioAllow) {
          game.audioAllow = false;
        } else {
          game.audioAllow = true;
        }
        if (game.audioAllow) {
          game.audioVolumeswitch('on');
          game.setup_button[0].image = game.voiceImage;
          game.setup_button[0].name = 'voiceImage';
        } else {
          game.audioVolumeswitch('off');
          game.setup_button[0].image = game.voiceOffImage;
          game.setup_button[0].name = 'voiceOffImage';
        }
      }
    }
    if (game.lworld === 'gogo') {
      game.audio.bullteMusic.load();
      game.bulletTime = 0;
      window.cancelAnimationFrame(game.bulletAllow);
      game.bulletAllow = null;
      if (game.failure) {
        if (game.mouseX > 500 && game.mouseY > 375 && game.mouseX < 600 && game.mouseY < 395) {
          window.location.reload();
        }
      }
      if (game.statistics) {
        if (game.mouseX > 500 && game.mouseY > 375 && game.mouseX < 600 && game.mouseY < 395) {
          game.EndlessMode = true;
          game.gameTime = new Date().getTime();
          game.nextEnemy = 200;
        }
      }
      if (game.weapons_system) {
        for (a = j = 0, ref = game.weapons_system_json["up_lv"]["xy"].length - 1; 0 <= ref ? j <= ref : j >= ref; a = 0 <= ref ? ++j : --j) {
          if (game.mouseX > game.weapons_system_json["open"]["xy"][a][0] && game.mouseY > game.weapons_system_json["open"]["xy"][a][1] && game.mouseX < game.weapons_system_json["open"]["xy"][a][0] + 50 && game.mouseY < game.weapons_system_json["open"]["xy"][a][1] + 20) {
            if (game.gemsNum[a] > 10) {
              game.bulletStyle = a + 1;
              game.gemsNum[a] -= 10;
            } else {
              game.energyHint.push(new game.hint(game.weapons_system_json["open"]["xy"][a][0], game.weapons_system_json["open"]["xy"][a][1]));
            }
          }
        }
      }
    }
  };
  document.onmousedown = function(e) {
    var x, y;
    if (game.lworld === 'gogo' && !game.pause) {
      x = game.mouseX;
      y = game.mouseY;
      game.bulletGo(x, y);
    }
  };
  document.oncontextmenu = function(e) {
    e.preventDefault();
    if (game.pause) {
      game.pause = false;
    } else {
      game.pause = true;
    }
    return false;
  };
  game.audioVolumeswitch('on');
  window.addEventListener('mousemove', function(e) {
    game.mousePosition.set(e);
    game.mouseX = game.mousePosition.x / game.scale;
    game.mouseY = game.mousePosition.y / game.scale;
  });
  window.addEventListener('mousemove', game.buttonHover_begin);
  window.addEventListener("mouseup", game.buttonUp_begin);
  game.buttonArray = game.begin_button;
  game.target = new game.targetFn(game.mouseX, game.mouseY);
  game.spaceShip = new game.hero(game.shipImgX, game.shipImgY, 66, 66, 'initial');
  for (m = j = 0; j <= 200; m = ++j) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.4, 0.5, 0.1, 'red'));
  }
  for (m = k = 0; k <= 100; m = ++k) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.6, 1, 0.1, 'red'));
  }
  for (m = l = 0; l <= 50; m = ++l) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.4, 1, 0.1, 'red'));
  }
  for (m = n = 0; n <= 20; m = ++n) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.4, 1.5, 0.4));
  }
  for (m = o = 0; o <= 20; m = ++o) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.6, 1.5, 0.5));
  }
  for (m = p = 0; p <= 10; m = ++p) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.2, 1.5, 1));
  }
  for (m = q = 0; q <= 2; m = ++q) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.6, 3, 2));
  }
  for (m = r = 0; r <= 2; m = ++r) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.6, 3, 1));
  }
  for (m = s = 0; s <= 2; m = ++s) {
    game.meteorArray.push(new game.meteor(Math.random() * 820, Math.random() * 620, 0.6, 3, 4));
  }
  game.radar = new game.hero(61, 576, 50, 50, 'radar');
  game.bossOne = new game.boss();
  game.jiguangpao = new game.jiguang();
  game.shipFlame = new game.flame();
  game.audio.beginMusic.play();
  return game.loop();
};
