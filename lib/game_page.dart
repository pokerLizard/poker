import 'dart:async';
import 'package:poker/card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:poker/game_table.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ServerEvent {
  final String name;
  final dynamic data;

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

StreamSocket? streamSocket;

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
IO.Socket connectAndListen(name) {
  streamSocket = StreamSocket();
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  socket.auth = {'name': name};

  socket.onConnect((_) {
    print('connect');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('state_update', (state) {
    streamSocket?.addResponse(ServerEvent("state update", state));
  });

  socket.onDisconnect((_) {
    print('${name} disconnented');
  });

  socket.connect();
  return socket;
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key, required this.playerName}) : super(key: key);
  final String playerName;

  @override
  Widget build(BuildContext context) {
    final socket = connectAndListen(playerName);
    return StreamBuilder<ServerEvent>(
        stream: streamSocket?.getResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          final state = snapshot.data?.data;
          final round = state['curRound'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              elevation: 0.0,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('????????????'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('??????'),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Leave?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      socket.emit('leave');
                                      socket.disconnect();
                                      streamSocket?.dispose();
                                      // leave dialog
                                      Navigator.of(context).pop();
                                      // leave table
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('no'))
                              ],
                            );
                          });
                    },
                  ),
                  ListTile(
                    title: const Text('????????????'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.grey,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 380,
                      child: GameTable(
                        playerName: playerName,
                        state: state,
                        socket: socket,
                      )),
                ),
                state['curRound'] == null ||
                        round['playerStates']?[playerName] == null
                    ? Container()
                    : SizedBox(
                        height: 140,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PokerCard(
                                    card: round['playerStates'][playerName]
                                        ['hand'][0],
                                  ),
                                  PokerCard(
                                    card: round['playerStates'][playerName]
                                        ['hand'][1],
                                  ),
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
                                        text:
                                            'Raise To\n', // default text style
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
