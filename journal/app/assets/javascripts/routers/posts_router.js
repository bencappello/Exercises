Journal.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'postsIndex',
    'posts/new': 'postNew',
    'posts/:id': 'postShow'

  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  postsIndex: function () {
    $('.content').empty();
  },

  postNew: function () {
    var post = new Journal.Models.Post();
    var view = new Journal.Views.PostForm({model: post, collection: Journal.posts})
    this.$rootEl.html(view.render().$el);
  },

  postShow: function (id) {
    var post = Journal.posts.getOrFetch(id);
    var view = new Journal.Views.PostShow({model: post, collection: Journal.posts});
    this.$rootEl.html(view.render().$el);
  }


});
