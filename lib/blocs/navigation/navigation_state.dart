import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigatingToEvent extends NavigationState {
  final String eventName;

  const NavigatingToEvent(this.eventName);

  @override
  List<Object> get props => [eventName];
}

class PanelClosed extends NavigationState {}
