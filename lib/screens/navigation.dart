import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  List<Node> nodes = [];
  List<Node> path = [];

  @override
  void initState() {
    super.initState();
    _initializeNodes();
  }

    void _initializeNodes() {
    Node topNode = Node('top', 120, 220);
    Node leftNode = Node('left', 20, 310);
    Node middleNode = Node('middle', 120, 310);
    Node rightNode = Node('right', 220, 310);
    Node bottomNode = Node('bottom', 120, 450);

    topNode.neighbors.addAll([middleNode]);
    leftNode.neighbors.addAll([middleNode]);
    middleNode.neighbors.addAll([topNode, leftNode, rightNode, bottomNode]);
    rightNode.neighbors.addAll([middleNode]);
    bottomNode.neighbors.addAll([middleNode]);

    nodes.addAll([topNode, leftNode, middleNode, rightNode, bottomNode]);

    path = aStarPathfinding(topNode, leftNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floor Plan')),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/floor_plan.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.contain,
          ),
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: PathPainter(path, nodes),
          ),
        ],
      ),
    );
  }
}

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

class Node {
  final String label;
  final double x, y;
  final List<Node> neighbors;

  Node(this.label, this.x, this.y) : neighbors = [];

  double distanceTo(Node other) {
    return ((x - other.x).abs() + (y - other.y).abs());
  }
}

List<Node> aStarPathfinding(Node start, Node goal) {
  List<Node> openSet = [start];
  List<Node> closedSet = [];
  Map<Node, double> gScore = {start: 0};
  Map<Node, double> fScore = {start: start.distanceTo(goal)};

  Map<Node, Node?> cameFrom = {};

  while (openSet.isNotEmpty) {
    Node current = openSet.reduce((a, b) => fScore[a]! < fScore[b]! ? a : b);

    if (current == goal) {
      return reconstructPath(cameFrom, current);
    }

    openSet.remove(current);
    closedSet.add(current);

    for (Node neighbor in current.neighbors) {
      if (closedSet.contains(neighbor)) continue;

      double tentativeGScore = gScore[current]! + current.distanceTo(neighbor);

      if (!openSet.contains(neighbor)) {
        openSet.add(neighbor);
      } else if (tentativeGScore >= gScore[neighbor]!) {
        continue;
      }

      cameFrom[neighbor] = current;
      gScore[neighbor] = tentativeGScore;
      fScore[neighbor] = gScore[neighbor]! + neighbor.distanceTo(goal);
    }
  }

  return [];
}

List<Node> reconstructPath(Map<Node, Node?> cameFrom, Node current) {
  List<Node> totalPath = [current];
  while (cameFrom[current] != null) {
    current = cameFrom[current]!;
    totalPath.add(current);
  }
  return totalPath.reversed.toList();
}
