(function (root) {
  var App = root.App = (root.App || {});

  var ChatUI = App.ChatUI = function (chat) {
    this.chat = chat
    this.$messages = $('#messages')
    this.eventHandlers();
    this.clientEmissionHandlers();
  };

  ChatUI.prototype.eventHandlers = function () {
    $('#chat-input').on('submit', this.handleSubmit.bind(this))
  };

  ChatUI.prototype.clientEmissionHandlers = function () {
    this.chat.socket.on('sendMessage', function (message) {
      var $txt = $('<p></p>');
      $txt.text(message.text);
      $txt.append($('<br>'));
      this.$messages.prepend($txt);
    }.bind(this));
  };

  ChatUI.prototype.handleSubmit = function (event) {
    event.preventDefault();
    var message = $('#text').val();
    this.chat.sendMessage(message)
  };


}(this));
