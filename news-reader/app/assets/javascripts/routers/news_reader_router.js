NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "": "feedsIndex",
    "feeds/:id": "feedShow"
  },


  feedsIndex: function () {

  },

  feedShow: function (id) {
    var model = NewsReader.feeds.getOrFetch(id);
    // debugger
    model.fetch();
    var view = new NewsReader.Views.FeedShow({
      collection: NewsReader.feeds,
      model: model
    })

    this.$rootEl.html(view.render().$el);
  }
});
