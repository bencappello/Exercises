Journal.Views.PostForm = Backbone.View.extend({

  template: JST['posts/form'], // JST['posts/index'],

  events: {
    'submit form': 'savePost'
  },

  initialize: function () {
    // this.listenTo(this.collection, "sync add change:title remove reset", this.render);
  },

  render: function (errors) {
    this.$el.html(this.template({model: this.model}));
    return this;
  },

  savePost: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();

    this.model.save(data, {
      success: function () {
        this.collection.add(this.model, {merge: true});
        Backbone.history.navigate('#', {trigger: true})
      }.bind(this),
      error: function (model, response) {
        $('.errors').empty();
        response.responseJSON.forEach(function (el) {
          var li = $('<li></li>');
          li.html(el);
          $('.errors').append(li);
        }.bind(this));
      }.bind(this)
    })
  }

});
