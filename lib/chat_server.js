
var nickNameAvailable = function (takenNames, name) {
  var taken = true;
  var namePrefix = name.slice(0, 5).toLowerCase();
  for (var sockID in takenNames) {
    if (takenNames[sockID] == name) {
      taken = false;
    }
  }
  return taken;
}

var createChat = function (server) {
  var io = require('socket.io')(server);
  var guestNumber = 0;
  var nicknames = {};

  io.on('connection', function (socket) {
    guestNumber += 1
    var guestName = "Guest" + guestNumber
    nicknames[socket.id] = guestName

    socket.on('message', function (data) {
      io.emit('sendMessage', { text: data.text });
    });

    socket.on('nicknameChangeRequest', function (data) {
      if (nickNameAvailable(nicknames, data.name)) {
        io.emit('nicknameChangeResult', {
          success: false,
          message: 'Name is taken.'
        });
      } else if (namePrefix == 'guest') {
        io.emit('nicknameChangeResult', {
          success: false,
          message: 'Names cannot begin with "Guest".'
        });
      } else {
        nicknames[socket.id] = data.name
        io.emit('nicknameChangeResult', {
          success: true,
          message: 'Nickname changed to ' + data.name + '.'
        });
      }

    });

  });
};

module.exports.createChat = createChat;
