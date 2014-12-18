(function() {
  window.Snakes = window.Snakes || {};

  var Snake = Snakes.Snake = function(size) {
    this.size = size;
    pos = [size/2, size/2];
    this.dir = "N";
    left = [pos[0] - 1, pos[0]];
    this.segments = [pos, left];
  }

  Snake.DIFFS = {
    "N": [0,1],
    "S": [0,-1],
    "W": [-1,0],
    "E": [1,0]
  }

  Snake.prototype.move = function() {
    var head = this.segments[0];
    var dir = Snake.DIFFS[this.dir];
    var newPos = [head[0] + dir[0], head[1] + dir[1]];
    this.segments.unshift(newPos);

    if (this.grow > 0)
      this.grow--
    else
      this.segments.pop();
  }

  Snake.prototype.turn = function(dir) {
    var reverse = Snake.DIFFS[this.dir].map(function(a) {
      return a * -1;
    });
    if (this.segments.length === 1 || (
        reverse[0] != Snake.DIFFS[dir][0] &&
        reverse[1] != Snake.DIFFS[dir][1])) {
      this.dir = dir;
    }
  }

  Snake.prototype.dead = function() {
    var head = this.segments[0];
    return (head[0] < 0 || head[0] >= this.size ||
        head[1] < 0 || head[1] >= this.size ||
        this.collidedWith(this.segments.slice(1)));
  }

  Snake.prototype.collidedWith = function(otherObj) {
    var head = this.segments[0];
    for (var i = 0; i < otherObj.length; i++) {
      var el = otherObj[i];
      if (el[0] == head[0] && el[1] == head[1])
        return true;
    }
    return false;
  }

  var Board = Snakes.Board = function(size) {
    this.size = size,
    this.snake = new Snake(size);
    this.resetApple();
    this.resetApplePic
  }

  Board.prototype.step = function() {
    if (this.snake.collidedWith([this.apple])) {
      this.snake.grow = 1;
      this.resetApple();
    }
    if (this.snake.dead()) {
      alert("You lose");
    }
    this.countDown-- ;
    if (this.countDown == 0) {
      this.resetApple();
    }
  }

  Board.prototype.resetApple = function() {
    var appleX = Math.floor(Math.random() * (this.size - 1));
    var appleY = Math.floor(Math.random() * (this.size - 1));
    this.apple = [appleX, appleY];
    this.resetApplePic();
    this.countDown = 30;
  }

  Board.prototype.resetApplePic = function() {
    this.applePic = $("<li class='apple-"+Math.floor(Math.random()*3)+"'></li>")
  }
})();
