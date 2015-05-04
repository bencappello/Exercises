Journal.Views.PostForm = Backbone.View.extend({

  template: JST['posts/form'], // JST['posts/index'],

  events: {
    'submit form': 'savePost'
  },

  initialize: function () {
    // this.listenTo(this.collection, "sync add change:title remove reset", this.render);
  },

  render: function (errors) {
    this.$el.empty();
    // console.log(this.collection.length)
    this.$el.html(this.template({model: this.model}));
    if (errors) {
      errors.forEach(function (error) {
        this.$el.prepend(error);
      }.bind(this))
    }
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
        this.render(JSON.parse(response.responseText))
      }.bind(this)
    })
  }

});
