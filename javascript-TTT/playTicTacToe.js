var TTT = require("./ttt")

var readline = require('readline')

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var tttGame = new TTT.Game(reader);

tttGame.run(function () {
  tttGame.reader.close();
})
