Journal.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'], // JST['posts/index'],

  events: {
    'click .delete-post': 'deletePost'
  },

  initialize: function () {
    this.listenTo(this.collection, "sync add change:title remove reset", this.render);
  },

  render: function () {
    this.$el.html(this.template({collection: this.collection}));
    return this;
  },

  deletePost: function (event) {
    var $target = $(event.currentTarget)
    var modelId = $target.data('id');
    var model = this.collection.get(modelId);
    model.destroy();
  }

});
