import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class StartNavigationEvent extends NavigationEvent {
  final String eventName;

  const StartNavigationEvent(this.eventName);

  @override
  List<Object> get props => [eventName];
}

class ClosePanelEvent extends NavigationEvent {}
