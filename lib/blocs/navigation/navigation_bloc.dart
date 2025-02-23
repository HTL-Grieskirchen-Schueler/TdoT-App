import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<StartNavigationEvent>((event, emit) {
      print("Starting navigation to: ${event.eventName}");
      emit(NavigatingToEvent(event.eventName));
    });

    on<ClosePanelEvent>((event, emit) {
      print("Closing panel");
      emit(PanelClosed());
    });
  }
}
