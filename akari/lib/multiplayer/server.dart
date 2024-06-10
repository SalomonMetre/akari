import 'dart:io';

class Server {
  ServerSocket? _serverSocket;
  Socket? _player1;
  Socket? _player2;

  void startServer(Function onClientConnected) async {
    _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);
    print('Server started on port 3000');

    _serverSocket?.listen((Socket client) {
      print('Client connected: ${client.remoteAddress.address}:${client.remotePort}');
      if (_player1 == null) {
        _player1 = client;
        _player1?.write('You are Player 1');
      } else if (_player2 == null) {
        _player2 = client;
        _player2?.write('You are Player 2');
        onClientConnected();
      } else {
        client.write('Game is full');
        client.close();
      }
    });
  }

  void sendMessageToOtherPlayer(Socket sender, String message) {
    if (sender == _player1 && _player2 != null) {
      _player2?.write(message);
    } else if (sender == _player2 && _player1 != null) {
      _player1?.write(message);
    }
  }

  void dispose() {
    _player1?.close();
    _player2?.close();
    _serverSocket?.close();
  }
}
