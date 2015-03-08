game.init = function() {
  game.ratio = game.width / game.height;
  game.currentHeight = game.height;
  game.currentWidth = game.width;
  game.canvas = document.getElementsByTagName("canvas")[0];
  game.ctx = game.canvas.getContext("2d");
  game.canvas.width = game.width;
  game.canvas.height = game.height;
  game.resize();
  game.loop();
  return game.Draw.rect(200, 200, 100, 100, 'green');
};
