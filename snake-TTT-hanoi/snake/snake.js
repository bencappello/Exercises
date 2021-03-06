(function() {
  window.Snakes = window.Snakes || {};

  var Snake = Snakes.Snake = function(size) {
    this.size = size;
    pos = [size/2, size/2];
    this.dirs = ["N"];
    left = [pos[0] - 1, pos[0]];
    this.segments = [pos, left];
  }

  Snake.DIFFS = {
    "N": [-1,0],
    "S": [1,0],
    "W": [0,-1],
    "E": [0,1]
  }

  Snake.prototype.move = function() {
    console.log(this.dirs)
    var dir = null
    //if dirs has only one element, no turn action has been keyed so just
    //move in that direction. Otherwise shift off the first dir which was
    //the old dir and then move in the direction of the first dir which is
    //the turn that keyed.
    if (this.dirs.length > 1) {
      this.dirs.shift();
    }
    dir = this.dirs[0]

    var moveDelta = Snake.DIFFS[dir];
    var head = this.segments[0];
    var newPos = [head[0] + moveDelta[0], head[1] + moveDelta[1]];
    newPos = this.wrap(newPos);
    this.segments.unshift(newPos);

    if (this.grow > 0)
      this.grow--
      else
        this.segments.pop();
      }

  Snake.prototype.wrap = function(pos) {
    pos[0] = (pos[0] % this.size);
    pos[1] = (pos[1] % this.size);

    if (pos[0] < 0) {
      pos[0] = (this.size - 1);
    }
    if (pos[1] < 0) {
      pos[1] = (this.size - 1);
    }
    return pos;
  }

  Snake.prototype.turn = function(dir) {
    var lastDir = this.dirs[this.dirs.length  - 1]
    var reverse = Snake.DIFFS[lastDir].map(function(a) {
      return a * -1;
    });


    if (this.segments.length === 1 || (
      reverse[0] != Snake.DIFFS[dir][0] &&
      reverse[1] != Snake.DIFFS[dir][1])) {
        this.dirs.push(dir);
      }
    }

  Snake.prototype.dead = function() {
    var head = this.segments[0];
    return this.collidedWith(this.segments.slice(1));
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
      this.snake.grow = 2;
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
    this.apple = [appleX, appleY]

    for (var i = 0; i < this.snake.segments.length; i++) {

      if (this.snake.segments.includesVector(this.apple)) {
        this.resetApple();
        return;
      }
    }
    this.resetApplePic();
    this.countDown = 50;
  }

  Board.prototype.resetApplePic = function() {
    this.applePic = $("<li class='apple-"+Math.floor(Math.random()*3)+"'></li>")
  }

  Array.prototype.includesVector = function(vec) {
    console.log(this)
    console.log(vec)
    for (var i = 0; i < this.length; i++) {
      var el = this[i];
      if (el[0] == vec[0] && el[1] == vec[1])
        return true;
    }
    return false;
  }
})();
