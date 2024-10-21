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
