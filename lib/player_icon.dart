import 'package:flutter/material.dart';

class PlayerIcon extends StatelessWidget {
  const PlayerIcon({
    Key? key,
    required this.name,
    required this.pocket,
  }) : super(key: key);
  final String name;
  final double pocket;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          CircleAvatar(
            child: Text(name),
          ),
          Text(name),
          Text("${pocket}bb"),
        ],
      ),
    );
  }
}
