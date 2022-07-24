import 'package:flutter/material.dart';

import 'game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnterPage(),
    );
  }
}

class EnterPage extends StatelessWidget {
  EnterPage({Key? key}) : super(key: key);
  final playerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: playerNameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "enter username",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return GamePage(
                    playerName: playerNameController.text,
                  );
                }));
              },
              child: const Text('Enter'),
            ),
          )
        ],
      ),
    );
  }
}
