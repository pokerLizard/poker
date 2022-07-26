import 'dart:math' as math;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:poker/player_icon.dart';

class GameTable extends StatelessWidget {
  const GameTable(
      {Key? key,
      required this.playerName,
      required this.state,
      required this.socket})
      : super(key: key);
  final dynamic state;
  final String playerName;
  final io.Socket socket;

  @override
  Widget build(BuildContext context) {
    final players = state['players'] as List;
    final offset = players.indexWhere((player) => player['name'] == playerName);
    final round = state['curRound'];
    final playerStates = round?['playerStates'];
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: TablePainter(),
              child: CustomMultiChildLayout(
                  delegate: PlayersLayoutsDelegate(),
                  children: players
                      .asMap()
                      .map((idx, player) {
                        return MapEntry(
                            idx,
                            LayoutId(
                                id: (idx - offset) % players.length,
                                child: PlayerIcon(
                                  name: player['name'],
                                  pocket: player['pocket'].toDouble(),
                                )));
                      })
                      .values
                      .toList()),
            )),
        Center(
          child: round != null
              ? Text("${round['pot']}bb")
              : ElevatedButton(
                  onPressed: () {
                    socket.emit('start_game');
                  },
                  child: const Text('Start Round')),
        ),
      ],
    );
  }
}

class PlayersLayoutsDelegate extends MultiChildLayoutDelegate {
  PlayersLayoutsDelegate();

  @override
  void performLayout(Size size) {
    const iconWidth = 100;
    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width - iconWidth;
    final height = size.height - iconWidth;
    final rectWidth = width / 2;
    final radius = height / 2;
    const radians = 35 * (math.pi / 180);
    final circlePosX = radius * math.cos(radians);
    final circlePosY = radius * math.sin(radians);

    final dx = center.dx - iconWidth / 2;
    final dy = center.dy - iconWidth / 2;

    final positions = [
      Offset(dx, dy + height / 2),
      Offset(dx - rectWidth / 2, dy + height / 2),
      Offset(dx - rectWidth / 2 - circlePosX, dy + circlePosY),
      Offset(dx - rectWidth / 2 - circlePosX, dy - circlePosY),
      Offset(dx - rectWidth / 2, dy - height / 2),
      Offset(dx, dy - height / 2),
      Offset(dx + rectWidth / 2, dy - height / 2),
      Offset(dx + rectWidth / 2 + circlePosX, dy - circlePosY),
      Offset(dx + rectWidth / 2 + circlePosX, dy + circlePosY),
      Offset(dx + rectWidth / 2, dy + height / 2),
    ];

    for (int i = 0; i < positions.length; ++i) {
      if (hasChild(i)) {
        layoutChild(i, BoxConstraints.loose(size));
        positionChild(i, positions[i]);
      }
    }
  }

  @override
  bool shouldRelayout(covariant PlayersLayoutsDelegate oldDelegate) {
    return false;
  }
}

class TablePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.black12;
    const iconWidth = 80;
    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width - iconWidth;
    final height = size.height - iconWidth;

    drawRect(width, height, paint) {
      final rectWidth = width / 2;
      final leftCirclePos = Offset(center.dx - rectWidth / 2, center.dy);
      canvas.drawArc(
        Rect.fromCenter(
          center: leftCirclePos,
          height: height,
          width: height,
        ),
        0.5 * math.pi,
        math.pi,
        false,
        paint,
      );
      final rightCirclePos = Offset(center.dx + rectWidth / 2, center.dy);
      canvas.drawArc(
        Rect.fromCenter(
          center: rightCirclePos,
          height: height,
          width: height,
        ),
        1.5 * math.pi,
        math.pi,
        false,
        paint,
      );
      final rectPos = Offset(center.dx - rectWidth / 2, center.dy - height / 2);
      canvas.drawRect(rectPos & Size(rectWidth, height), paint);
    }

    drawRect(width, height, paint);
    paint = Paint()..color = const Color(0xff638965);
    drawRect(width - 20, height - 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
