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
  int _x = 120;
  int _y = 350;
  String _targetRoom = '';

  List<Node> nodes = [];

  NavigationBloc(this._repository) : super(NavigationInitial()) {
    on<StartNavigationEvent>((event, emit) async {
      try {
        nodes = await _repository.getNodes();
        _targetRoom = event.room;

        List<Node> path = _getPath(_x, _y, event.room, nodes);

        final svgData = await _repository.getSvg(_selectedFloor);

        final updatedSvg = _drawNavigationOnSvg(svgData, path, _x, _y);

        emit(PanelClosed());
        emit(SvgUpdated(updatedSvg));
      } catch (e) {
        print("Failed to start navigation: $e");
      }
    });

    on<PositionChangedEvent>((event, emit) async {
      try {
        final svgData = await _repository.getSvg(event.floor);

        _x = event.x;
        _y = event.y;

        if (nodes.isNotEmpty) {
          final path = _getPath(event.x, event.y, _targetRoom, nodes);
          print("Path: $path");
          final updatedSvg =
              _drawNavigationOnSvg(svgData, path, event.x, event.y);

          emit(SvgUpdated(updatedSvg));
        } else {
          final updatedSvg = _drawPositionOnSvg(svgData, event.x, event.y);
          emit(SvgUpdated(updatedSvg));
        }
      } catch (e) {
        print("Failed to update position: $e");
      }
    });
  }

  String _drawPositionOnSvg(String svgData, int x, int y) {
    final String personSvg = '<circle cx="$x" cy="$y" r="5" fill="red" />';
    return svgData.replaceFirst('</svg>', '$personSvg</svg>');
  }

  List<Node> _getPath(int startX, int startY, String room, List<Node> nodes) {
    Node? endNode = nodes.firstWhere(
      (node) => node.name == room,
      orElse: () => throw Exception("Target node with name '$room' not found"),
    );
    print(
        "End node found: ${endNode.name} (${endNode.width}, ${endNode.height})");

    Node? nearestNode;
    double minDistance = double.infinity;

    for (var node in nodes) {
      if (node.neighbors.length == 1 && node.id != endNode.id) {
        continue;
      }

      final nodeX = int.parse(node.width);
      final nodeY = int.parse(node.height);
      final distance = _calculateDistance(startX, startY, nodeX, nodeY);

      if (distance < minDistance) {
        minDistance = distance;
        nearestNode = node;
      }
    }

    if (nearestNode == null) {
      throw Exception(
          "No nearest node found for coordinates ($startX, $startY)");
    }
    print(
        "Nearest node found: ${nearestNode.name} (${nearestNode.width}, ${nearestNode.height})");

    final bfsPath = _bfs(nearestNode, endNode, nodes);

    print("Path:");
    for (var node in bfsPath) {
      print(
          "Node ID: ${node.id}, Name: ${node.name}, Coordinates: (${node.width}, ${node.height})");
    }

    return bfsPath;
  }

  double _calculateDistance(int x1, int y1, int x2, int y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  List<Node> _bfs(Node startNode, Node endNode, List<Node> nodes) {
    final queue = <List<Node>>[];
    final visited = <int>{};

    queue.add([startNode]);
    visited.add(startNode.id);

    while (queue.isNotEmpty) {
      final currentPath = queue.removeAt(0);
      final currentNode = currentPath.last;

      if (currentNode.id == endNode.id) {
        return currentPath;
      }

      for (var neighborId in currentNode.neighbors) {
        final neighbor = nodes.firstWhere((n) => n.id == neighborId);

        if (neighbor.neighbors.length == 1 && neighbor.id != endNode.id) {
          continue;
        }

        if (!visited.contains(neighborId)) {
          visited.add(neighborId);
          queue.add([...currentPath, neighbor]);
        }
      }
    }

    throw Exception(
        "No path found from (${startNode.name}) to (${endNode.name})",);
  }

  String _drawNavigationOnSvg(
      String svgData, List<Node> path, int startX, int startY,) {
    final document = xml.XmlDocument.parse(svgData);

    final svgElement = document.rootElement;

    final groupElement = xml.XmlElement(xml.XmlName('g'))
      ..setAttribute('stroke', 'blue')
      ..setAttribute('stroke-width', '2');

    if (path.isNotEmpty) {
      final firstNode = path.first;

      final firstX = double.parse(firstNode.width);
      final firstY = double.parse(firstNode.height);

      final startLineElement = xml.XmlElement(xml.XmlName('line'))
        ..setAttribute('x1', startX.toString())
        ..setAttribute('y1', startY.toString())
        ..setAttribute('x2', firstX.toString())
        ..setAttribute('y2', firstY.toString());

      groupElement.children.add(startLineElement);
    }

    for (var i = 0; i < path.length - 1; i++) {
      final currentNode = path[i];
      final nextNode = path[i + 1];

      final currentX = double.parse(currentNode.width);
      final currentY = double.parse(currentNode.height);
      final nextX = double.parse(nextNode.width);
      final nextY = double.parse(nextNode.height);

      final lineElement = xml.XmlElement(xml.XmlName('line'))
        ..setAttribute('x1', currentX.toString())
        ..setAttribute('y1', currentY.toString())
        ..setAttribute('x2', nextX.toString())
        ..setAttribute('y2', nextY.toString());

      groupElement.children.add(lineElement);
    }

    svgElement.children.add(groupElement);

    return document.toXmlString(pretty: true);
  }
}
