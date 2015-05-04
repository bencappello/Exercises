NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST['feeds/new'],

  events: {
    "click button.add-feed": "addFeed"
  },

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  addFeed: function (event) {
    event.preventDefault();

    var data = $("form").serializeJSON();

    var newFeed = new NewsReader.Models.Feed();

    newFeed.save(data, {
      success: function () {
        NewsReader.feeds.add(newFeed);
        $('input').val("");
      },

      error: function (model, response) {
        var $ul = $('ul.errors');
        var $li = $("<li></li>").html(response.responseJSON.error);
        $ul.append($li)
      }
    });
  }
})
