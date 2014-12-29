window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Journal.posts = new Journal.Collections.Posts();
    Journal.posts.fetch();

    var router = new Journal.Routers.Router({$rootEl: $('.content')});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
