game.init = function() {
  game.ratio = game.width / game.height;
  game.currentHeight = game.height;
  game.currentWidth = game.width;
  game.canvas = document.getElementsByTagName("canvas")[0];
  game.ctx = game.canvas.getContext("2d");
  game.canvas.width = game.width;
  game.canvas.height = game.height;
  game.resize();
  window.addEventListener('mousemove', function(e) {
    game.mousePosition.set(e);
    game.mouseX = game.mousePosition.x / game.scale;
    return game.mouseY = game.mousePosition.y / game.scale;
  });
  return game.loop();
};
