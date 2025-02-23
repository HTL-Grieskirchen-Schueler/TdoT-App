import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigatingToEvent extends NavigationState {
  final String room;

  const NavigatingToEvent(this.room);

  @override
  List<Object> get props => [room];
}

class SvgUpdated extends NavigationState {
  final String svgData;

  const SvgUpdated(this.svgData);

  @override
  List<Object> get props => [svgData];
}

class PanelClosed extends NavigationState {}