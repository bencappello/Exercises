Journal.Views.PostShow = Backbone.View.extend({

  template: JST['posts/show'], // JST['posts/index'],

  events: {
    'dblclick div': 'editPost',
    'blur input': 'savePost'
  },

  initialize: function () {
    this.listenTo(this.model, "sync add change:title remove reset", this.render);
  },

  render: function () {
    this.$el.html(this.template({model: this.model, edit: false}));
    return this;
  },

  editPost: function (event) {
    var target = $(event.currentTarget).data('attribute')
    this.$el.html(this.template({model: this.model, edit: target}));
    return this;
  },

  savePost: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();

    this.model.save(data, {
      success: function () {
        this.collection.add(this.model, {merge: true});
        Backbone.history.navigate(('#posts/' + this.model.id), {trigger: true})
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
