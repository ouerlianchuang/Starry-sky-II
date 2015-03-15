game.loop = function() {
  window.requestAnimationFrame(game.loop);
  game.update();
  return game.render();
};
