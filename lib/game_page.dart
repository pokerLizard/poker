import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:poker/game_table.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ServerEvent {
  final String name;
  final Object data;

  ServerEvent(this.name, this.data);
}

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<ServerEvent>();

  void Function(ServerEvent) get addResponse => _socketResponse.sink.add;

  Stream<ServerEvent> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.auth = {'username': 'Jeff'};

  socket.onConnect((_) {
    print('connect');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('users', (users) {
    streamSocket.addResponse(ServerEvent("userConnected", users));
  });
  socket.onDisconnect((_) => print('disconnect'));
  socket.connect();
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    connectAndListen();
    return StreamBuilder<ServerEvent>(
        stream: streamSocket.getResponse,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          print(snapshot.data?.data);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              elevation: 0.0,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('補充籌碼'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('離桌'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('離座觀戰'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.grey,
            body: Column(
              children: [
                const SizedBox(height: 400, child: GameTable()),
                SizedBox(
                  height: 140,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayingCardView(
                                card: PlayingCard(Suit.clubs, CardValue.nine)),
                            PlayingCardView(
                                card: PlayingCard(Suit.clubs, CardValue.nine)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Fold'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Call'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Raise To\n', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '\$1000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
