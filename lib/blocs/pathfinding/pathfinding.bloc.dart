import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/node.model.dart';
import 'pathfinding.event.dart';
import 'pathfinding.state.dart';

class PathfindingBloc extends Bloc<PathfindingEvent, PathfindingState> {
  PathfindingBloc() : super(PathfindingInitial()) {
    on<InitializeNodesEvent>(_onInitializeNodes);
    on<FindPathEvent>(_onFindPath);
  }

  void _onInitializeNodes(InitializeNodesEvent event, Emitter<PathfindingState> emit) {
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

    List<Node> nodes = [topNode, leftNode, middleNode, rightNode, bottomNode];
    emit(NodesInitialized(nodes));
  }

  void _onFindPath(FindPathEvent event, Emitter<PathfindingState> emit) {
    List<Node> path = aStarPathfinding(event.startNode, event.endNode);
    emit(PathFound(path));
  }
}