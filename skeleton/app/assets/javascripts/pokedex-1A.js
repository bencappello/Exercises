// pokemon = Models.Pokemon
Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $('<li>').addClass('poke-list-item');
  $li.data('id', pokemon.get('id')); // data-id=1
  var attrs = pokemon.escape('name') + ', ' + pokemon.escape('poke_type');
  $li.append(attrs);
  this.$pokeList.append($li);
};

// should fetch all the Pokemon by fetching this.pokes
Pokedex.RootView.prototype.refreshPokemon = function (callback) {

  // this has to be .models --
  var that = this;
  this.pokes.fetch({
    success: function() {
      that.pokes.each(function(poke) { that.addPokemonToList(poke); })
    }
  });


};
