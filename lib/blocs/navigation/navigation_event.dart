import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class StartNavigationEvent extends NavigationEvent {
  final String room;
  final int floor;
  final int x;
  final int y;

  const StartNavigationEvent(this.room, this.floor, this.x, this.y);

  @override
  List<Object> get props => [room, floor, x, y];
}

class PositionChangedEvent extends NavigationEvent {
  final int x;
  final int y;
  final int floor;

  const PositionChangedEvent(this.x, this.y, this.floor);

  @override
  List<Object> get props => [x, y, floor];
}

class FetchSvgEvent extends NavigationEvent {
  final int floor;

  const FetchSvgEvent(this.floor);

  @override
  List<Object> get props => [floor];
}
