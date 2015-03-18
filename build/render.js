"use strict";
game.render = function() {
  var i, j, ref;
  game.Draw.clear();
  game.audio.beginMusic.play();
  game.ctx.drawImage(game.backgroundImage_login, game.bImgX, game.bImgY, 820, 620, 0, 0, 820, 620);
  for (i = j = 0, ref = game.buttonArray.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    game.ctx.drawImage(game.buttonArray[i].image, 0, 0, game.buttonArray[i].w, game.buttonArray[i].h, game.buttonArray[i].x, game.buttonArray[i].y, game.buttonArray[i].w, game.buttonArray[i].h);
  }

  /*if game.lworld is 'help'
  
  if game.lworld is 'author'
  
  if game.lworld is 'go'　
  
  if game.lworld is 'gogo'
   */
  return game.target.render();
};
