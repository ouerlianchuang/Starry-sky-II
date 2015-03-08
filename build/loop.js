game.loop = function() {
  window.setTimeout(game.loop, 1000 / 60);
  game.update;
  return game.render;
};
