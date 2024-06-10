import 'dart:io';

class Client {
  late Socket _socket;
  Function(String) onMessageReceived;

  Client({required this.onMessageReceived});

  Future<void> connectToServer(String address, int port) async {
    _socket = await Socket.connect(address, port);
    _socket.listen((data) {
      onMessageReceived(String.fromCharCodes(data).trim());
    });
  }

  void sendMessage(String message) {
    _socket.write(message);
  }

  void dispose() {
    _socket.close();
  }
}
