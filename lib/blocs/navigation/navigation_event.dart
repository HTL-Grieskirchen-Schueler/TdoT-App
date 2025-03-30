import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class StartNavigationEvent extends NavigationEvent {
  final String room;

  const StartNavigationEvent(this.room);

  @override
  List<Object> get props => [room];
}

class PositionChangedEvent extends NavigationEvent {
  final int x;
  final int y;
  final int floor;

  const PositionChangedEvent(this.x, this.y, this.floor);

  @override
  List<Object> get props => [x, y, floor];
}