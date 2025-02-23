import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class StartNavigationEvent extends NavigationEvent {
  final String room;
  final int floor;

  const StartNavigationEvent(this.room, this.floor);

  @override
  List<Object> get props => [room, floor];
}


class UpdateSvgWithPathEvent extends NavigationEvent {
  final String updatedSvg;

  const UpdateSvgWithPathEvent(this.updatedSvg);

  @override
  List<Object> get props => [updatedSvg];
}

class ClosePanelEvent extends NavigationEvent {}