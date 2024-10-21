import '../../models/node.model.dart';

abstract class PathfindingState {}

class PathfindingInitial extends PathfindingState {}

class NodesInitialized extends PathfindingState {
  final List<Node> nodes;
  NodesInitialized(this.nodes);
}

class PathFound extends PathfindingState {
  final List<Node> path;
  PathFound(this.path);
}
