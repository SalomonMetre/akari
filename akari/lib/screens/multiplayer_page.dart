import 'package:akari/multiplayer/client.dart';
import 'package:akari/multiplayer/server.dart';
import 'package:akari/screens/multiplayer_game_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiplayerPage());
}

class MultiplayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplayer Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  late Server server;
  late Client client;

  void _startServer() {
    server = Server();
    server.startServer(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MultiPlayerGamePage(server: server, difficulty: 'Easy',)),
      );
    });
  }

  void _connectToServer() {
    client = Client(onMessageReceived: _handleMessageFromServer);
    client.connectToServer('10.188.213.182', 3000).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MultiPlayerGamePage(client: client, difficulty: 'Easy',)),
      );
    });
  }

  void _handleMessageFromServer(String message) {
    if (message == 'You are Player 1' || message == 'You are Player 2') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MultiPlayerGamePage(client: client, difficulty: 'Easy',)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiplayer Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startServer,
              child: Text('Start Server'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _connectToServer,
              child: Text('Connect to Server'),
            ),
          ],
        ),
      ),
    );
  }
}
