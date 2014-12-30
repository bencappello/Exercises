NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: 'api/feeds',
  model: NewsReader.Models.Feed,

  getOrFetch: function (id) {
    var object = this.get(id);

    if (!object) {
      object = new NewsReader.Models.Feed({ id: id });

      object.fetch({
        success: function () {
          this.add(object);
        }.bind(this)
      });
    }
    
    return object;
  }
});
