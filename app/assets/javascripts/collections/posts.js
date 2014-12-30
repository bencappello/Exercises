Journal.Collections.Posts = Backbone.Collection.extend({

  model: Journal.Models.Post,
  url: "/posts",

  getOrFetch: function (id) {
    var collection = this
    if (this.get(id)) {
      return this.get(id);
    } else {
      var post = new Journal.Models.Post({id: id});
      post.fetch({
        success: function () {
          collection.add(post);
        }
      });

      return post;
    }
  }

});
