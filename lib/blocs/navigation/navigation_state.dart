import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class SvgUpdated extends NavigationState {
  final String svgData;

  const SvgUpdated(this.svgData);

  @override
  List<Object> get props => [svgData];
}

class PositionUpdated extends NavigationState {
  final String svgData;
  final int x;
  final int y;

  const PositionUpdated(this.svgData, this.x, this.y);

  @override
  List<Object> get props => [svgData, x, y];
}

class PanelClosed extends NavigationState {}