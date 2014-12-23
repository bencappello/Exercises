Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail'
  },

  pokemonDetail: function (id, callback) {
    console.log(id);
  },

  pokemonIndex: function (callback) {
    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    pokemonIndex.refreshPokemon();
    $("#pokedex .pokemon-list").html(pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
