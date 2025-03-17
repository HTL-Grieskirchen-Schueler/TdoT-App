import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdot_gkr/models/trial_day_registration.model.dart';

import '../../resources/trial_day_repository.dart';

part 'trial_day_registration.state.dart';
part 'trial_day_registration.event.dart';

class TrialDayRegistrationBloc
    extends Bloc<TrialDayRegistrationEvent, TrialDayRegistrationState> {
  final TrialDayRepository _repository = TrialDayRepository();
  TrialDayRegistrationBloc() : super(const TrialDayRegistrationInitialState()) {
    on<InitializeEvent>(_onInitialize);
    on<RegisterEvent>(_onRegisterForTrialDay);
  }

  void _onInitialize(
    InitializeEvent event,
    Emitter<TrialDayRegistrationState> emit,
  ) async {
    try {
      final infoText = await _repository.getTrialDayInfo();
      final date = await _repository.getTrialDayDate();

      emit(
        TrialDayRegistrationInitializedState(
          dates: date,
          infoText: infoText,
        ),
      );
    } catch (error) {
      emit(
        TrialDayRegistrationLoadingErrorState(
          errorMessage: error.toString().substring(11),
        ),
      );
    }
  }

  void _onRegisterForTrialDay(
    RegisterEvent event,
    Emitter<TrialDayRegistrationState> emit,
  ) async {
    try {
      await _repository.registerForTrialDay(event.registration);
      event.onSuccess();
    } catch (error) {
      event.onError(error.toString().substring(11));
    } finally {}
  }
}
