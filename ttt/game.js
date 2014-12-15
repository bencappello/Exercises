var Board = require("./board");

function Game(reader) {
  this.board = new Board();
  this.reader = reader;
  this.lastMark = "O";
}

Game.prototype.nextMark = function() {
  return this.lastMark == "X" ? "O" : "X";
}

Game.prototype.run = function (completionCallback) {
  console.log("Welcome to Tic-Tac-Toe!");
  this.play(completionCallback)
}


Game.prototype.play = function(completionCallback) {
  this.board.show();
  var game = this;

  if (this.board.won() == true) {
    console.log("Congratulations " + game.lastMark + "! You are the winner.");
    completionCallback();
  }
  else if (this.board.tied() == true) {
    console.log("Tie game..... Man this shit is boring");
    completionCallback();
  }
  else {
    game.reader.question(game.nextMark() + "'s move. Choose a row ", function(arg1) {
      game.reader.question("Choose a column ", function(arg2) {
        var column = parseInt(arg1);
        var row = parseInt(arg2);

        if (game.board.placeMark([column, row], game.nextMark())) {
          game.lastMark = game.nextMark();
          game.play(completionCallback);
        }
        else {
          console.log("You can't move there!")
          game.play(completionCallback);
        }
    })
  })
}
}

module.exports = Game;
