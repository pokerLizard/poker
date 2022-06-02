import 'package:flutter/material.dart';

class PlayerIcon extends StatelessWidget {
  const PlayerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        children: const [
          CircleAvatar(
            child: Text("fish"),
          ),
          Text("yofish"),
          Text("\$10000.00"),
        ],
      ),
    );
  }
}
