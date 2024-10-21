import 'package:flutter/material.dart';

import 'node.model.dart';

class PathPainter extends CustomPainter {
  final List<Node> path;
  final List<Node> nodes;

  PathPainter(this.path, this.nodes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < path.length - 1; i++) {
      final start = Offset(path[i].x + 85, path[i].y + 85);
      final end = Offset(path[i + 1].x + 85, path[i + 1].y + 85);
      canvas.drawLine(start, end, paint);
    }

    for (var node in nodes) {
      final center = Offset(node.x + 85, node.y + 85);
      canvas.drawCircle(center, 10.0, nodePaint);
    }

    for (var node in path) {
      final center = Offset(node.x + 85, node.y + 85);
      canvas.drawCircle(center, 12.0, paint..color = Colors.green);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
