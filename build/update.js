"use strict";
game.update = function() {
  game.target.x = game.mouseX;
  game.target.y = game.mouseY;
  return game.target.update();
};
