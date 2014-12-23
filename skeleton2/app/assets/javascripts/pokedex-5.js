Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon()
  },

  addPokemonToList: function (pokemon) {
    var $li = JST.pokemonListItem({pokemon: pokemon});
    this.$el.append($li);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: this.render.bind(this)
    })
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function(pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
    return this;
  },

  selectPokemonFromList: function (event) {
    var $tar = $(event.target)
    var poke = this.collection.get($tar.data('id'));
    var pokemonDetail = new Pokedex.Views.PokemonDetail( {model: poke} );
    pokemonDetail.refreshPokemon();
    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li' : 'selectToyFromList'
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: this.render.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    var $detail = JST.pokemonDetail({ pokemon: this.model })
    this.$el.html($detail)

    this.model.toys().each(function(toy) {
      var $toy = JST.toyListItem({toy: toy});
      this.$el.find('ul.toys').append($toy);
    }.bind(this));
    return this;
  },

  selectToyFromList: function (event) {
    var $tar = $(event.target)
    var toy = this.model.toys().get($tar.data('id'));
    var toyDetail = new Pokedex.Views.ToyDetail({ model: toy });
    $("#pokedex .toy-detail").html(toyDetail.render().$el);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var $details = JST.toyDetail({ toy: this.model, pokes: [] });
    this.$el.html($details);
    return this;
  }
});


$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
