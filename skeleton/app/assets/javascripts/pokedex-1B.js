Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  pokemon.fetch({
    success: function () {
      $("div.pokemon-detail").empty();
      // build pokemon attributes definition list
      var $detail = $("<div>").addClass("detail");
      $detail.append("<img src='" + pokemon.escape('image_url') + "' alt=''>");
      var dl = "<dl>";
      for (var attr in pokemon.attributes) {
        if (attr == 'image_url') {
          continue;
        } else if (attr == 'moves') {
          var moves = pokemon.escape(attr).split(", ");
          dl += "<dt>moves</dt>";
          moves.forEach( function(move) {
            dl += "<dd>" + move + "</dd>";
          });
          continue;
        } else {
          // escape
          dl += "<dt>" + attr + "</dt><dd>" + pokemon.escape(attr) + "</dd>";
        }
      }

      $detail.append(dl);
      $detail.append($('<ul>').addClass('toys'));
      this.$pokeDetail.append($detail);
      // build pokemon toys ul
      this.renderToysList(pokemon.toys());


    }.bind(this)
  })

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data('id');
  var pokemon = this.pokes.get({ id: id });
  this.renderPokemonDetail(pokemon);
};
