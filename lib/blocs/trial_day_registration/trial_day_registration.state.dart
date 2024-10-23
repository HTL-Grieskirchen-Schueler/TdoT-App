part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationState {
  const TrialDayRegistrationState();
}

class TrialDayRegistrationInitialState extends TrialDayRegistrationState {
  const TrialDayRegistrationInitialState();
}

class TrialDayRegistrationInitializedState extends TrialDayRegistrationState {
  const TrialDayRegistrationInitializedState();
}

class TrialDayRegistrationSuccessState extends TrialDayRegistrationState {
  const TrialDayRegistrationSuccessState();
}

class TrialDayRegistrationFailureState extends TrialDayRegistrationState {
  final String errorMessage;

  const TrialDayRegistrationFailureState(this.errorMessage);
}

class TrialDayRegistrationLoadingErrorState extends TrialDayRegistrationState {
  final String errorMessage;

  const TrialDayRegistrationLoadingErrorState(this.errorMessage);
}
