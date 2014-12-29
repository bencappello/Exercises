window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    posts = new Journal.Collections.Posts();
    posts.fetch();
    var view = new Journal.Views.PostsIndex({collection: posts});
    $('body').append(view.render().$el);
  }
};

$(document).ready(function(){
  Journal.initialize();
});
