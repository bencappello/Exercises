var readline = require('readline')

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, compFn) {
  if (numsLeft == 0) {
    compFn(sum);
    return;
  }

  reader.question("Type in a number", function(answer) {
    sum += parseInt(answer)
    console.log(sum);
    addNumbers(sum, numsLeft - 1, compFn)
  })

}


addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
  reader.close();
});
