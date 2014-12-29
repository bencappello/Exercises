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

    Journal.indexView = new Journal.Views.PostsIndex({collection: Journal.posts});
    $('.sidebar').html(Journal.indexView.render().$el);
  }
};

$(document).ready(function(){
  Journal.initialize();
});
