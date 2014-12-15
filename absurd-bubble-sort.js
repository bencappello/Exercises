var readline = require('readline')

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var askIfLessThan = function(el1, el2, callback) {
  reader.question(("Is the first number smaller than the second? " + el1 + " " + el2), function(answer) {
    if (answer == "yes") {
      callback(true);
    }
    else {
      callback(false);
    }
  });
}

var innerBubbleSortLoop = function(arr, i, anySwaps, outerBubbleSortLoop) {
  if(i == arr.length - 1) {
    outerBubbleSortLoop(anySwaps);
  }
  else{
    askIfLessThan(arr[i], arr[i + 1], function(isLessThan){
      if (isLessThan == false) {
        temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        anySwaps = true;
      }
      else {
        anySwaps = false;
      }
      innerBubbleSortLoop(arr, (i + 1), anySwaps, outerBubbleSortLoop);
    })
  }
}

var absurdBubbleSort = function (arr, sortCompletionCallback) {
  var outerBubbleSortLoop = function (anySwaps) {
    if (anySwaps == true) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
