import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdot_gkr/models/trial_day_registration.model.dart';

import '../../resources/api_repository.dart';

part 'trial_day_registration.state.dart';
part 'trial_day_registration.event.dart';

class TrialDayRegistrationBloc
    extends Bloc<TrialDayRegistrationEvent, TrialDayRegistrationState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  TrialDayRegistrationBloc() : super(TrialDayRegistrationLoading()) {
    on<Initialize>(_onInitialize);
    on<RegisterForTrialDay>(_onRegisterForTrialDay);
  }

  void _onInitialize(
      Initialize event, Emitter<TrialDayRegistrationState> emit) {
    _apiRepository.getNextTrialDay().then((nextTrialDay) {
      emit(TrialDayRegistrationLoaded(nextTrialDay));
    }).catchError((error) {
      emit(TrialDayRegistrationLoadingError(error.toString()));
    });
  }

  void _onRegisterForTrialDay(
      RegisterForTrialDay event, Emitter<TrialDayRegistrationState> emit) {
    _apiRepository
        .postTrialDayRegistration(event.registration)
        .then((postedRegistration) {
      emit(TrialDayRegistrationRegistered(postedRegistration));
    }).catchError((error) {
      emit(TrialDayRegistrationError(error.toString()));
    });
  }
}
