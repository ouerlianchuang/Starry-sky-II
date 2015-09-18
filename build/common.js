"use strict";
var game;

game = {
  mouseX: 0,
  mouseY: 0,
  canvas: null,
  ctx: null,
  scale: 1,
  ratio: null,
  width: 820,
  height: 620,
  currentWidth: null,
  currentHeight: null,
  bImgX: 0,
  bImgY: 0,
  shipImgX: 300,
  shipImgY: 300,
  music: 1,
  lworld: 'begin',
  bossOne: false,
  bulletArray: [],
  bulletTime: 0,
  bulletPower: 1,
  bulletAllow: null,
  bulletStyle: 2,
  bulletNum: 0,
  bulletConsume: 0,
  damage: 0,
  damage_show: 0,
  hit: 0,
  ammoUse: 0,
  ammoUse_show: 0,
  hurt: 0,
  hurt_show: 0,
  hitrate: 0,
  openShield: false,
  quakeAllow: false,
  heroLife: 10,
  infiniteLife: false,
  whiteLine: [],
  buttonArray: [],
  audio: {},
  audioAllow: true,
  energyValue: 0,
  shield: false,
  energyGuidingRotate: false,
  energyGuidingRotateNum: -50,
  opacityGoBlack: 1,
  opacityGoBlack_internal: 0,
  goIntroductionImageheigh: 0,
  pause: false,
  rot: 0,
  leftkey: false,
  rightkey: false,
  downkey: false,
  upkey: false,
  shipSpeed: 2,
  scores_num: 0,
  scores_view: '00000',
  enemySpeed: 0,
  enemyArray: [],
  nextEnemy: 20,
  explodeArray: [],
  weapons_system: false,
  weapons_system_x: 810,
  weapons_system_json: {
    "up_lv": {
      "xy": [[450, 285], [450, 335], [450, 385], [615, 285], [615, 335], [615, 385]],
      "Whether": [[false, 'weaponsSystemImage_button_one'], [false, 'weaponsSystemImage_button_one'], [false, 'weaponsSystemImage_button_one'], [false, 'weaponsSystemImage_button_one'], [false, 'weaponsSystemImage_button_one'], [false, 'weaponsSystemImage_button_one']]
    },
    "open": {
      "xy": [[570, 290], [570, 340], [570, 390], [730, 290], [730, 340], [730, 390]],
      "Whether": [[false, 'weaponsSystemImage_close'], [false, 'weaponsSystemImage_close'], [false, 'weaponsSystemImage_close'], [false, 'weaponsSystemImage_close'], [false, 'weaponsSystemImage_close'], [false, 'weaponsSystemImage_close']]
    }
  },
  failure: false,
  particleArray: [],
  gemsArray: [],
  shieldSupplyArray: [],
  gemsNum: [0, 0, 0, 0, 0, 0],
  energyTextArray: [],
  energyHint: [],
  fireBallArray: [],
  fireBallHintTime: 400,
  fireBallAllow: false,
  fireBallDangerHintImageAllow: false,
  bossOneDangerHintImageAllow: false,
  bossOneAllow: false,
  bossOneHintTime: 200,
  bossOneHintSpeed: 0,
  bossOneBallArray: [],
  bossOneBallNum: 0,
  bossOneBallTime: 0,
  bossOneBallOneAllow: false,
  bossOneBallTwoAllow: false,
  victoryOne: false,
  bossScores: 200,
  statistics: false,
  statisticsTime: 200,
  lvRandomNum: 0,
  lvNum: 0,
  lvRandomSx: 0,
  lvMidLeft: -179,
  lvMidRight: 825,
  gameTimeIn: 0,
  EndlessMode: false,
  meteorArray: []
};