window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    NewsReader.feeds = new NewsReader.Collections.Feeds();
    NewsReader.feeds.fetch();

    var view = new NewsReader.Views.FeedsIndex({
      collection: NewsReader.feeds
    });

    var newForm = new NewsReader.Views.FeedNew();

    $('#sidebar').html(view.render().$el).append(newForm.render().$el);

    var router = new NewsReader.Routers.Router({
      $rootEl: $('#content')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
