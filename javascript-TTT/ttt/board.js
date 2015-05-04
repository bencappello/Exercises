function Board() {
  this.grid = new Array(3);
  for (var i = 0; i < this.grid.length; i++) {
    this.grid[i] = [null, null, null];
  }
}

Array.prototype.transpose = function(){
  var result, temp_result;
  result = [];
  for(i=0; i<this.length; i++){
    temp_result = [];
    for(j=0; j<this.length; j++){
      temp_result.push(this[j][i]);
    };
    result.push(temp_result);
  };
  return result;

};

Board.prototype.getMark = function(pos) {
  return this.grid[pos[0]][pos[1]];
}

Board.prototype.won = function() {
  var transposedGrid = this.grid.transpose();
  var board = this

  var marks = ["X", "O"]

  var checkMark = function (mark) {
    var found = false;

    var threeInRow = function (row) {
      for (var i = 0; i < row.length; i++) {
        if (row[i] !== mark) {
          return false;
        }
      }
      return true;
    }

    for (var i = 0; i < board.grid.length; i++) {
      if (threeInRow(board.grid[i])) {
        found = true;
      }
    }

    for (var i = 0; i < transposedGrid.length; i++) {

      if (threeInRow(transposedGrid[i])) {
        found = true;
      }
    }

    var diagRight = [board.grid[0][0], board.grid[1][1], board.grid[2][2]];
    var diagLeft = [board.grid[0][2], board.grid[1][1], board.grid[2][0]];

    if (threeInRow(diagRight) || threeInRow(diagLeft)){
      found = true;
    }

    return found;
  };

  var result = false;

  if (checkMark("X") || checkMark("O")) {
    result = true;
  }

  return result;
}

Board.prototype.winner = function() {

}

Board.prototype.empty = function(pos) {
  if (this.getMark(pos) === null) {
    return true;
  }
  else {
    return false;
  }
}

Board.prototype.tied = function () {
  return (this.full() && (!this.won()));
}

Board.prototype.full = function () {
  var flattened = this.grid.reduce(function (a, b) {
    return a.concat(b);
  });
  for (var i = 0; i < flattened.length; i++) {
    if (flattened[i] === null) {
      return false;
    }
  }
  return true;
}

Board.prototype.placeMark = function(pos, mark) {
  if (this.empty(pos)){
    this.grid[pos[0]][pos[1]] = mark;
    return true;
  }
  else {
    return false;
  }
}

Board.prototype.show = function() {
  for (var i = 0; i < this.grid.length; i++) {
    console.log(JSON.stringify(this.grid[i]));
  }

}


// var board = new Board();

// board.placeMark([1,1], "X");
// board.show();
// board.placeMark([0,1], "O");
// board.show()
// console.log(board.won())



//woohoo

module.exports = Board;
