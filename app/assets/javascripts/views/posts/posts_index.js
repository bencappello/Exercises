Journal.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'], // JST['posts/index'],

  events: {
    'click .delete-post': 'deletePost'
  },

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    this.$el.empty();
    console.log(this.collection.length)
    this.$el.html(this.template({collection: this.collection}));
    return this;
  },

  deletePost: function () {
    
  }

});
