import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdot_gkr/models/node.model.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';
import 'package:xml/xml.dart' as xml;

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavigationRepository _repository;
  final int _selectedFloor = 0;
  int _x = 0;
  int _y = 0;
  //bool _isNavigating = false;

  List<Node> nodes = [
    Node(id: 1, name: "e13", width: "80", height: "90", story: 0, neighbors: [2, 21]),
    Node(id: 2, name: "e14", width: "198", height: "90", story: 0, neighbors: [1, 3]),
    Node(id: 3, name: "e15", width: "316", height: "90", story: 0, neighbors: [2, 4]),
    Node(id: 4, name: "e16", width: "418", height: "90", story: 0, neighbors: [3, 5]),
    Node(id: 5, name: "e17", width: "519", height: "90", story: 0, neighbors: [4, 6]),
    Node(id: 6, name: "e18", width: "620", height: "90", story: 0, neighbors: [5, 7, 19]),
    Node(id: 7, name: "e19", width: "710", height: "90", story: 0, neighbors: [6, 8]),
    Node(id: 8, name: "e20", width: "800", height: "90", story: 0, neighbors: [7, 22]),
    Node(id: 9, name: "stiegeEingang", width: "90", height: "270", story: 0, neighbors: [14, 24]),
    Node(id: 10, name: "e07", width: "220", height: "310", story: 0, neighbors: [11, 14, 15, 24]),
    Node(id: 11, name: "e05", width: "370", height: "310", story: 0, neighbors: [10, 12, 16, 17]),
    Node(id: 12, name: "e04", width: "500", height: "310", story: 0, neighbors: [11, 17, 13, 25]),
    Node(id: 13, name: "e02", width: "650", height: "310", story: 0, neighbors: [12, 23, 25]),
    Node(id: 14, name: "e33", width: "167", height: "270", story: 0, neighbors: [9, 24, 15, 10]),
    Node(id: 15, name: "e32", width: "254", height: "270", story: 0, neighbors: [14, 16, 10]),
    Node(id: 16, name: "e31", width: "341", height: "270", story: 0, neighbors: [15, 17, 10, 11]),
    Node(id: 17, name: "e30", width: "428", height: "270", story: 0, neighbors: [16, 11, 12]),
    Node(id: 18, name: "wcEg", width: "603", height: "220", story: 0, neighbors: [19, 25]),
    Node(id: 19, name: "stiegeBuffet", width: "603", height: "150", story: 0, neighbors: [6, 18]),
    Node(id: 21, name: "eckeE13", width: "60", height: "110", story: 0, neighbors: [1, 24]),
    Node(id: 22, name: "eckeE20", width: "800", height: "110", story: 0, neighbors: [8, 23]),
    Node(id: 23, name: "eckeE01", width: "800", height: "290", story: 0, neighbors: [13, 22]),
    Node(id: 24, name: "eckeE09", width: "60", height: "290", story: 0, neighbors: [9, 10, 14, 21]),
    Node(id: 25, name: "eckeE02", width: "620", height: "290", story: 0, neighbors: [12, 13, 18]),
  ];

  NavigationBloc(this._repository) : super(NavigationInitial()) {
    on<StartNavigationEvent>((event, emit) async {
      //_isNavigating = true;
      print("event" + event.room);
      //var nodes = await NavigationRepository().getNodes();
      List<Node> path = _getPath(_x, _y, "e02", nodes);
      final svgData = await _repository.getSvg(event.floor);
      final updatedSvg = _drawNavigationOnSvg(svgData, path);
      
      emit(PanelClosed());
      emit(SvgUpdated(updatedSvg));
    });

    on<PositionChangedEvent>((event, emit) async {

      try {
        final svgData = await _repository.getSvg(event.floor);

        if (event.floor == _selectedFloor) {
          final updatedSvg = _drawPositionOnSvg(svgData, event.x, event.y);
          _x = event.x;
          _y = event.y;
          emit(PositionUpdated(updatedSvg, event.x, event.y));
        } else {
          emit(SvgUpdated(svgData));
        }
      } catch (e) {
        print("Failed to update position: $e");
      }
    });

    on<FetchSvgEvent>((event, emit) async {
      try {
        final svgData = await _repository.getSvg(event.floor);

        if (event.floor == _selectedFloor) {
          final updatedSvg = _drawPositionOnSvg(svgData, _x, _y);
          emit(PositionUpdated(updatedSvg, _x, _y));
        } else {
          // Emit the SVG without the red dot if the floors don't match
          emit(SvgUpdated(svgData));
        }
      } catch (e) {
        print("Failed to fetch SVG: $e");
      }
    });
  }

  String _drawPositionOnSvg(String svgData, int x, int y) {
    final String personSvg = '<circle cx="$x" cy="$y" r="5" fill="red" />';
    return svgData.replaceFirst('</svg>', '$personSvg</svg>');
  }

  List<Node> _getPath(int startX, int startY, String room, List<Node> nodes) {
  List<Node> path = [];

  // Find the end node based on the room name
  Node? endNode;
  for (var node in nodes) {
    if (node.name == room) {
      endNode = node;
      break;
    }
  }

  if (endNode == null) {
    throw Exception("Target node with name '$room' not found");
  }

  // Find the nearest node to the starting coordinates (startX, startY)
  Node? nearestNode;
  double minDistance = double.infinity;

  for (var node in nodes) {
    final nodeX = int.parse(node.width);
    final nodeY = int.parse(node.height);
    final distance = _calculateDistance(startX, startY, nodeX, nodeY);

    if (distance < minDistance) {
      minDistance = distance;
      nearestNode = node;
    }
  }

  if (nearestNode == null) {
    throw Exception("No nearest node found for coordinates ($startX, $startY)");
  }

  // Use BFS to find the shortest path from the nearest node to the end node
  final bfsPath = _bfs(nearestNode, endNode, nodes);

  // Combine the start node, nearest node, and BFS path
  final startNode = Node(
    id: -1,
    name: "start",
    width: startX.toString(),
    height: startY.toString(),
    story: 0,
    neighbors: [],
  );

  path.add(startNode);
  path.add(nearestNode);
  path.addAll(bfsPath);

  return path;
}

// Helper function to calculate Euclidean distance between two points
double _calculateDistance(int x1, int y1, int x2, int y2) {
  return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
}

// BFS algorithm to find the shortest path between two nodes
List<Node> _bfs(Node startNode, Node endNode, List<Node> nodes) {
  final queue = <Node>[];
  final visited = <int>{};
  final parent = <int, int>{}; // To reconstruct the path

  queue.add(startNode);
  visited.add(startNode.id);

  while (queue.isNotEmpty) {
    final currentNode = queue.removeAt(0);

    // If the target node is found, reconstruct the path
    if (currentNode.id == endNode.id) {
      final path = <Node>[];
      int? nodeId = currentNode.id;

      while (nodeId != null) {
        final node = nodes.firstWhere((n) => n.id == nodeId);
        path.add(node);
        nodeId = parent[nodeId];
      }

      return path.reversed.toList(); // Reverse to get the correct order
    }

    // Explore neighbors
    for (var neighborId in currentNode.neighbors) {
      if (!visited.contains(neighborId)) {
        final neighbor = nodes.firstWhere((n) => n.id == neighborId);
        queue.add(neighbor);
        visited.add(neighborId);
        parent[neighborId] = currentNode.id; // Track the parent for path reconstruction
      }
    }
  }

  // If no path is found
  throw Exception("No path found from (${startNode.name}) to (${endNode.name})");
}

String _drawNavigationOnSvg(String svgData, List<Node> path) {
  // Parse the SVG data into an XML document
  final document = xml.XmlDocument.parse(svgData);

  // Find the root <svg> element
  final svgElement = document.rootElement;

  // Create a <g> (group) element to hold the navigation lines
  final groupElement = xml.XmlElement(xml.XmlName('g'))
    ..setAttribute('stroke', 'blue') // Line color
    ..setAttribute('stroke-width', '2'); // Line thickness

  // Iterate through the path and draw lines between consecutive nodes
  for (var i = 0; i < path.length - 1; i++) {
    final currentNode = path[i];
    final nextNode = path[i + 1];

    // Parse the coordinates of the current and next nodes
    final currentX = double.parse(currentNode.width);
    final currentY = double.parse(currentNode.height);
    final nextX = double.parse(nextNode.width);
    final nextY = double.parse(nextNode.height);

    // Create a <line> element for the navigation path
    final lineElement = xml.XmlElement(xml.XmlName('line'))
      ..setAttribute('x1', currentX.toString())
      ..setAttribute('y1', currentY.toString())
      ..setAttribute('x2', nextX.toString())
      ..setAttribute('y2', nextY.toString());

    // Add the <line> element to the <g> group
    groupElement.children.add(lineElement);
  }

  // Add the <g> group to the <svg> element
  svgElement.children.add(groupElement);

  // Convert the modified XML document back to a string
  return document.toXmlString(pretty: true);
}
}