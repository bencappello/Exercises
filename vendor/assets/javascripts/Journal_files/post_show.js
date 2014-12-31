Journal.Views.PostShow = Backbone.View.extend({

  template: JST['posts/show'], // JST['posts/index'],

  events: {

  },

  initialize: function () {
    this.listenTo(this.model, "sync add change:title remove reset", this.render);
  },

  render: function () {
    this.$el.empty();
    // console.log(this.collection.length)
    this.$el.html(this.template({model: this.model}));
    return this;
  }

});
