import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blocs/pathfinding/pathfinding.bloc.dart';
import '../blocs/pathfinding/pathfinding.event.dart';
import '../blocs/pathfinding/pathfinding.state.dart';
import '../models/node.model.dart';
import '../models/pathpainter.model.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathfindingBloc()..add(InitializeNodesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Floor Plan')),
        body: BlocBuilder<PathfindingBloc, PathfindingState>(
          builder: (context, state) {
            if (state is NodesInitialized) {
              return Stack(
                children: [
                  SvgPicture.asset(
                    'assets/floor_plan.svg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    painter: PathPainter([], state.nodes),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Node startNode = state.nodes.firstWhere(
                          (node) => node.label == 'top');
                      Node endNode = state.nodes.firstWhere(
                          (node) => node.label == 'left');
                      context
                          .read<PathfindingBloc>()
                          .add(FindPathEvent(startNode, endNode));
                    },
                    child: const Text('Find Path'),
                  ),
                ],
              );
            } else if (state is NodesInitialized || state is PathFound) {
              List<Node> path = state is PathFound ? state.path : [];
              List<Node> nodes = state is NodesInitialized ? state.nodes : (state as PathFound).path;

              return Stack(
                children: [
                  SvgPicture.asset(
                    'assets/floor_plan.svg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.contain,
                  ),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    painter: PathPainter(path, nodes),
                  ),
                  if (state is NodesInitialized)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          Node startNode = state.nodes.firstWhere((node) => node.label == 'top');
                          Node endNode = state.nodes.firstWhere((node) => node.label == 'left');
                          context.read<PathfindingBloc>().add(FindPathEvent(startNode, endNode));
                        },
                        child: const Text('Find Path'),
                      ),
                    ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}