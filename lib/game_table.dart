import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:poker/player_icon.dart';

class GameTable extends StatelessWidget {
  const GameTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
              height: 300,
              width: 600,
              child: CustomPaint(
                painter: TablePainter(),
                child: CustomMultiChildLayout(
                  delegate: PlayersLayoutsDelegate(),
                  children: List.generate(
                    10,
                    (i) => LayoutId(
                      id: i,
                      child: const PlayerIcon(),
                    ),
                  ).toList(),
                ),
              )),
        ),
      ],
    );
  }
}

class PlayersLayoutsDelegate extends MultiChildLayoutDelegate {
  PlayersLayoutsDelegate();

  @override
  void performLayout(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rectWidth = size.width / 2;
    final radius = size.height / 2;
    const radians = 35 * (math.pi / 180);
    final circlePosX = radius * math.cos(radians);
    final circlePosY = radius * math.sin(radians);
    const iconWidth = 80;

    final dx = center.dx - iconWidth / 2;
    final dy = center.dy - iconWidth / 2;

    final positions = [
      Offset(dx, dy - size.height / 2),
      Offset(dx + rectWidth / 2, dy - size.height / 2),
      Offset(dx + rectWidth / 2 + circlePosX, dy - circlePosY),
      Offset(dx + rectWidth / 2 + circlePosX, dy + circlePosY),
      Offset(dx + rectWidth / 2, dy + size.height / 2),
      Offset(dx, dy + size.height / 2),
      Offset(dx - rectWidth / 2, dy + size.height / 2),
      Offset(dx - rectWidth / 2 - circlePosX, dy + circlePosY),
      Offset(dx - rectWidth / 2 - circlePosX, dy - circlePosY),
      Offset(dx - rectWidth / 2, dy - size.height / 2),
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
    var paint = Paint()..color = const Color(0xff638965);
    final center = Offset(size.width / 2, size.height / 2);
    final rectWidth = size.width / 2;
    final leftCirclePos = Offset(center.dx - rectWidth / 2, center.dy);
    canvas.drawCircle(leftCirclePos, size.height / 2, paint);
    final rightCirclePos = Offset(center.dx + rectWidth / 2, center.dy);
    canvas.drawCircle(rightCirclePos, size.height / 2, paint);
    final rectPos =
        Offset(center.dx - rectWidth / 2, center.dy - size.height / 2);
    canvas.drawRect(rectPos & Size(rectWidth, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
