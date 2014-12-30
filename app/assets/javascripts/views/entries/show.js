NewsReader.Views.EntryShow = Backbone.View.extend({
  template: JST['entries/show'],
  tagName: 'li',

  render: function () {
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }
})
