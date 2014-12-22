Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>").addClass("toy-list-item").data("toy-id", toy.escape('id')).data('pokemon-id', toy.escape('pokemon_id'));
  var $dl = $("<dl>");
  $dl.append("<dt>name</dt>" + "<dd>" + toy.escape('name') + "</dd>");
  $dl.append("<dt>happiness</dt>" + "<dd>" + toy.escape('happiness') + "</dd>");
  $dl.append("<dt>price</dt>" + "<dd>" + toy.escape('price') + "</dd>");

  $li.append($dl);
  this.$pokeDetail.find('ul.toys').append($li);

};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var $div = $('<div>').addClass('detail');
  $div.append("<img src='" + toy.get('image_url') + "' alt='toy picture'>");
  this.$toyDetail.append($div);

  var pokemonSelectBox = "<select class='poke-select' data-pokemon-id='" + toy.escape('pokemon_id') + "' data-toy-id='" + toy.escape('id') + "'>"

  this.pokes.forEach( function (poke) {
    pokemonSelectBox += "<option value='" + poke.escape("id") + "'"
    if (poke.escape("id") == toy.escape("pokemon_id")) {
      pokemonSelectBox += " selected"
    }
    pokemonSelectBox += ">" + poke.escape("name") + "</option>"
  });

  this.$toyDetail.append(pokemonSelectBox)
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokeId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  var pokemon = new Pokedex.Models.Pokemon({ id: pokeId });
  pokemon.fetch({
    success: function(model, res, options) {
      var toy = pokemon.toys().get(toyId);
      this.renderToyDetail(toy);
    }.bind(this)
  });

};
