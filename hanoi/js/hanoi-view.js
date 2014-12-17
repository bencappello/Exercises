(function() {
  window.Hanoi = window.Hanoi || {};

  var View = Hanoi.View = function(game, $el) {
    this.game = game,
    this.$el = $el;
    this.render();
  }

  View.prototype.render = function() {
    var $piles = $("<section class='group'></section>");
    var view = this;
    this.game.towers.forEach(function(pile) {
      var $pile = $("<ul class='pile'></ul>");
      $pile.data("id", view.game.towers.indexOf(pile));
      for (var i = 0; i < 3; i++) {
        var $disc = $("<li class='disc-" + pile[i] + "'></li>");
        $pile.prepend($disc);
      }
      $piles.append($pile);
    });
    this.$el.empty()
    this.$el.append($piles);
    this.bindEvents();
  }

  View.prototype.bindEvents = function () {
    var that = this;
    $("ul").on("click", function(event){
      console.log("CLICK");
      that.clickTower($(event.currentTarget));
    });
  };

  View.prototype.clickTower = function($pile) {
    if (this.fromPile) {
      if (!this.game.move(this.fromPile.data("id"), $pile.data("id"))) {
        alert("Invalid Move!");
      }
      this.fromPile = null;
      this.render();
    } else {
      this.fromPile = $pile;
    }
    if (this.game.isWon()) {
      alert("Congratulations! You are the smartest person in the room.");
      $("ul").off();
    }
  }

})();
