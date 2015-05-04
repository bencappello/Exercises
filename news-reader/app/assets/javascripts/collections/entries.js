NewsReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function (models, options) {
    this.feed = options.feed;
  },

  model: NewsReader.Models.Entry,

  comparator: function (left, right) {
    var lef = left.get("published_at"),
        rite = right.get("published_at");

    if (lef < rite) {
      return 1;
    } else if (rite < lef) {
      return -1;
    } else {
      return 0;
    }
  },

  url: function () {
    return this.feed.url() + '/entries';
  }


})
