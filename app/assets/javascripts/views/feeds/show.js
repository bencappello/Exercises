NewsReader.Views.FeedShow = Backbone.View.extend ({
  template: JST['feeds/show'],
  tagName: 'section',

  events: {
    "click button.refresh-feed": "refreshFeed"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    var el = this.$el.find("ul.entries");
    this.model.entries().forEach(function (entry) {
      var view = new NewsReader.Views.EntryShow({ model: entry });
      el.append(view.render().$el);
    });

    return this;
  },

  refreshFeed: function (event) {

    Backbone.history.navigate('#/feeds/' + this.model.id, { trigger: true });
  }
})
