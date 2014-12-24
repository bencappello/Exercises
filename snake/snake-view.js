(function() {
  window.Snakes = window.Snakes || {};

  var View = Snakes.View = function($el) {
    this.board = new Snakes.Board(20);
    this.$el = $el;
    this.render();
    this.bindKeyEvent();
    setInterval(this.step.bind(this), 1000/View.FRAMERATE);
  }

  View.FRAMERATE = 10;

  View.prototype.step = function() {
    if (this.board.snake.dead()) {
      return;
    }
    this.board.snake.move();
    this.board.step()
    this.render();
  }

  View.prototype.bindKeyEvent = function() {
    var that = this;
    $('body').on("keydown", function(event) {
      that.handleKeyEvent(event);
    });
  }

  View.prototype.handleKeyEvent = function(event) {
    key = event.keyCode;
    keys = {37: "W", 38: "N", 39: "E", 40: "S"}
    if (keys[key])
      this.board.snake.turn(keys[key]);
    }

  View.prototype.render = function() {
    var $board = $("<section class='group'></section>");
    var view = this;
    var snake = this.board.snake
    for (var i = 0; i < view.board.size; i++) {
      var $row = $("<ul class='row'></ul>");
      for (var j = 0; j < view.board.size; j++) {
        var $space = null;
        if ([snake.segments[0]].includesVector([i,j])) {
          $space = $("<li class='head'></li>");
          // "<li class='disc-" + pile[i] + "'></li>"
        } else if (snake.segments.slice(1).includesVector([i,j])) {
          $space = $("<li class='snake'></li>");
        } else if (this.board.apple[0] == i && this.board.apple[1] == j) {
          $space = this.board.applePic;
        } else
          $space = $("<li class='space'></li>");

        $row.append($space);
      }
      $board.append($row);
    }
    this.$el.empty();
    this.$el.append($board);
  }
})();

Array.prototype.includesVector = function(vec) {
  for (var i = 0; i < this.length; i++) {
    var el = this[i];
    if (el[0] == vec[0] && el[1] == vec[1])
      return true;
  }
  return false;
}
