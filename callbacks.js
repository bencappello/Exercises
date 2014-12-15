function Clock () {
  this.currentTime = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var h, m, s;
  h = this.currentTime.getHours();
  m = this.currentTime.getMinutes();
  s = this.currentTime.getSeconds();
  console.log(h + ":" + m + ":" + s);
};

Clock.prototype.run = function () {
  this.printTime();
  setTimeout(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // debugger;
  this.currentTime.setMilliseconds(this.currentTime.getMilliseconds() + Clock.TICK);
  this.printTime();
};

var clock = new Clock();
// clock.printTime();
clock.run();
