Journal.Collections.Posts = Backbone.Collection.extend({

  model: Journal.Models.Post,
  url: "/posts",

  getOrFetch: function (id) {

    if (this.get(id)) {
      return this.get(id);
    } else {
      var post = new Journal.Models.Post({id: id});
      post.fetch();
      this.add(post);
      return post;
    }
  }

});
