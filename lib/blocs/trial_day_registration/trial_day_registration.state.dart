part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationState {
  final String infoText;

  const TrialDayRegistrationState({this.infoText = ''});
}

class TrialDayRegistrationInitialState extends TrialDayRegistrationState {
  const TrialDayRegistrationInitialState() : super();
}

class TrialDayRegistrationInitializedState extends TrialDayRegistrationState {
  const TrialDayRegistrationInitializedState(String infoText)
      : super(infoText: infoText);
}

class TrialDayRegistrationSuccessState extends TrialDayRegistrationState {
  const TrialDayRegistrationSuccessState(String infoText)
      : super(infoText: infoText);
}

class TrialDayRegistrationFailureState extends TrialDayRegistrationState {
  final String errorMessage;

  const TrialDayRegistrationFailureState(this.errorMessage, String infoText)
      : super(infoText: infoText);
}

class TrialDayRegistrationLoadingErrorState extends TrialDayRegistrationState {
  final String errorMessage;

  const TrialDayRegistrationLoadingErrorState(this.errorMessage) : super();
}
