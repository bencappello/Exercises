$.TweetCompose = function (el) {
  this.$el = $(el);
  this.handleSubmit();
};


$.TweetCompose.prototype.handleSubmit = function () {
  var that = this;
  this.$el.on("submit", function (event) {
    that.submit();
  });
};

$.TweetCompose.prototype.render = function () {

};

$.TweetCompose.prototype.handleSuccess = function () {

};

$.TweetCompose.prototype.clearInput = function () {

};

$.TweetCompose.prototype.submit = function () {
  var formContent = this.$el.find("textarea").html();
  var $users = this.$el.find("option")

  for (var i = 0; i < $users.length; i++) {
    if ($users[i].prop('selected')) {
      formMentioned_user_ids = $users[i].val();
    }
  }

  var params = {
    tweet : {
      content : formContent ,
      mentioned_user_ids : formMentioned_user_ids
    }
  }

  params = JSON.stringify(params);
  $(':input')
  $.ajax() {
    type: 'POST',
    url: "/tweets",
    data: params,
    dataType: 'JSON',
    success: function () {

    },
    fail: function () {
      console.log('failed');
    }
  }
};


$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};


$(function () {
  $(".tweet-compose").tweetCompose();
});
