import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:poker/game_table.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
  }
}
