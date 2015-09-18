var Game;

Game = (function() {
  var initCavns;

  function Game(challenge) {}

  initCavns = function() {
    return this.canvas = document.getElementsByTagName("canvas")[0];
  };

  return Game;

})();
