import '../../models/node.model.dart';

abstract class PathfindingEvent {}

class InitializeNodesEvent extends PathfindingEvent {}

class FindPathEvent extends PathfindingEvent {
  final Node startNode;
  final Node endNode;

  FindPathEvent(this.startNode, this.endNode);
}
