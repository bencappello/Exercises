NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'sync add', this.render);
  },

  render: function () {
    this.$el.html(this.template({ feeds: this.collection }));
    return this;
  }

})
