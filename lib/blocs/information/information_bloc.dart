import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdot_gkr/resources/information_repository.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  final InformationRepositroy _repository = InformationRepositroy();

  InformationBloc() : super(InformationInitial()) {
    on<InitializeEvent>(_onInitialize);
  }

  void _onInitialize(
    InitializeEvent event,
    Emitter<InformationState> emit,
  ) async {
    try {
      final infoText = await _repository.getInformationText();

      emit(
        InformationInitializedState(
          infoText: infoText,
        ),
      );
    } catch (error) {
      emit(
        InformationLoadingErrorState(
          errorMessage: error.toString().substring(11),
        ),
      );
    }
  }
}
