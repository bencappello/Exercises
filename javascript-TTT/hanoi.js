var readline = require('readline')

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = [[3,2,1],[],[]]
}

HanoiGame.prototype.isWon = function () {
  if (this.stacks[1].length == 3 || this.stacks[2].length == 3){
    return true;
  }
}

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  if (this.stacks[startTowerIdx].length == 0) {
    return false;
  }
  else if (this.stacks[endTowerIdx].length == 0) {
    return true;
  }
  else if (this.stacks[startTowerIdx].slice(-1) > this.stacks[endTowerIdx].slice(-1)) {
      return false;
    }
  else {
    return true;
  }
}

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  }
  else {
    return false;
  }
}

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.stacks))
}

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Where do you want to move a disc from? ", function (fromAnswer) {
    reader.question("Where do you want to move it to? ", function (toAnswer) {
      var fromNum = parseInt(fromAnswer);
      var toNum = parseInt(toAnswer);

      callback(fromNum, toNum);
    })
  })
}

HanoiGame.prototype.run = function (completionCallback) {
  if (this.isWon()) {
    console.log("Congratulations! You're a genius!");
    completionCallback();
  }
  else {
    // this.promptMove(this.move.bind(this));
    // if (moved == false) {
    //   console.log("Invalid move!");
    // }
    // else {
    //   this.run(completionCallback);
    // }

    var that = this
    this.promptMove(function (arg1, arg2) {
      moved = that.move(arg1, arg2);
      if (moved == false) {
        console.log("Invalid move!");
      }

      that.run(completionCallback);
    })
  }
}


var game = new HanoiGame();
game.run(function () {
  reader.close();
})
