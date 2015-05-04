NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  events: {
    "click button.delete-feed": "deleteFeed"
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync add remove', this.render);
  },

  render: function () {
    this.$el.html(this.template({ feeds: this.collection }));
    return this;
  },

  deleteFeed: function (event) {
    var id = $(event.currentTarget).parent().data("id");
    this.collection.get(id).destroy();
  }

})
