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
    $('#sidebar').html(view.render().$el);

    var router = new NewsReader.Routers.Router({
      $rootEl: $('#content')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
