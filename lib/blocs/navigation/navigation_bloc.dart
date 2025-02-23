import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';
import 'package:tdot_gkr/models/node.model.dart';
import 'dart:math';
import 'package:collection/collection.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<StartNavigationEvent>((event, emit) async {
      try {
        // Fetch nodes from backend
        final nodes = await NavigationRepository().getNodes();

        // Find the destination node by name
        final destinationNode =
            nodes.firstWhere((node) => node.name == event.room, orElse: () => Node(id: -1, name: '', width: '0', height: '0'));

        if (destinationNode.id == -1) {
          emit(NavigationInitial()); // No valid path
          print("No valid path");
          return;
        }

        // Starting position (100,100)
        final startPosition = {'x': 100, 'y': 100};

        // Calculate the shortest path (Placeholder function, you need to implement it)
        final path = _calculateShortestPath(startPosition, destinationNode, nodes);

        // Get SVG file
        final svgData = await NavigationRepository().getSvg(0);

        // Modify the SVG with the path
        final updatedSvg = _drawPathOnSvg(svgData, path);

        // Emit the updated SVG state
        emit(SvgUpdated(updatedSvg));
      } catch (e) {
        emit(NavigationInitial()); // Handle errors
      }
    });

    on<ClosePanelEvent>((event, emit) {
      print("Closing panel");
      emit(PanelClosed());
    });
  }

  List<Map<String, int>> _calculateShortestPath(Map<String, int> start,Node destination,List<Node> nodes,) {
  // Convert node list into a graph representation
  Map<int, List<Map<String, dynamic>>> graph = {};

  for (var node in nodes) {
    graph[node.id] = [];

    for (var neighbor in nodes) {
      if (node.id != neighbor.id) {
        double distance = _euclideanDistance(node, neighbor);
        graph[node.id]!.add({'node': neighbor, 'distance': distance});
      }
    }
  }

  // Apply Dijkstra's Algorithm
  Map<int, double> distances = {};
  Map<int, Node?> previous = {};
  Set<int> visited = {};
  PriorityQueue<Map<String, dynamic>> queue = PriorityQueue(
    (a, b) => (a['distance'] as double).compareTo(b['distance'] as double),
  );

  // Initialize distances
  for (var node in nodes) {
    distances[node.id] = double.infinity;
    previous[node.id] = null;
  }

  // Add starting position as a virtual node
  int startNodeId = -1;
  distances[startNodeId] = 0;
  graph[startNodeId] = nodes.map((node) {
    double distance = _distanceToStart(start, node);
    return {'node': node, 'distance': distance};
  }).toList();

  queue.add({'node': startNodeId, 'distance': 0});

  while (queue.isNotEmpty) {
    var current = queue.removeFirst();
    int currentNodeId = current['node'];

    if (visited.contains(currentNodeId)) continue;
    visited.add(currentNodeId);

    if (currentNodeId == destination.id) break;

    for (var neighbor in graph[currentNodeId] ?? []) {
      Node neighborNode = neighbor['node'];
      double newDistance = distances[currentNodeId]! + neighbor['distance'];

      if (newDistance < distances[neighborNode.id]!) {
        distances[neighborNode.id] = newDistance;
        previous[neighborNode.id] = currentNodeId == startNodeId ? null : nodes.firstWhere((n) => n.id == currentNodeId);
        queue.add({'node': neighborNode.id, 'distance': newDistance});
      }
    }
  }

  // Reconstruct the path
  List<Map<String, int>> path = [];
  Node? step = destination;
  while (step != null) {
    path.add({'x': int.parse(step.width), 'y': int.parse(step.height)});
    step = previous[step.id];
  }
  
  path.add(start); // Add start position
  return path.reversed.toList(); // Return the path in correct order
}

  // Helper function to calculate Euclidean distance between nodes
  double _euclideanDistance(Node a, Node b) {
    int x1 = int.parse(a.width);
    int y1 = int.parse(a.height);
    int x2 = int.parse(b.width);
    int y2 = int.parse(b.height);
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  // Helper function to calculate distance from start position to a node
  double _distanceToStart(Map<String, int> start, Node node) {
    int x1 = start['x']!;
    int y1 = start['y']!;
    int x2 = int.parse(node.width);
    int y2 = int.parse(node.height);
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  String _drawPathOnSvg(String svgData, List<Map<String, int>> path) {
  if (path.isEmpty) return svgData; // Ensure path is not empty

  // Get the first position (starting point)
  final int x = path[0]['x']!;
  final int y = path[0]['y']!;

  // Add a red dot to indicate the starting position
  final String dotSvg = '<circle cx="10" cy="10" r="5" fill="red" />';
  print("drawing dot");

  // Insert dot before </svg>
  return svgData.replaceFirst('</svg>', '$dotSvg</svg>');
}

}
