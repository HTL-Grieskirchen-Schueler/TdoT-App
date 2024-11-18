part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationState extends Equatable {
  const TrialDayRegistrationState();

  @override
  List<Object> get props => [];
}

class TrialDayRegistrationInitialState extends TrialDayRegistrationState {
  const TrialDayRegistrationInitialState() : super();
}

class TrialDayRegistrationInitializedState extends TrialDayRegistrationState {
  final List<DateTime> dates;
  final String infoText;

  const TrialDayRegistrationInitializedState(
      {required this.dates, required this.infoText})
      : super();

  @override
  List<Object> get props => [dates, infoText];
}

class TrialDayRegistrationSuccessState extends TrialDayRegistrationState {
  final List<DateTime> dates;
  final String infoText;

  const TrialDayRegistrationSuccessState(
      {required this.dates, required this.infoText})
      : super();

  @override
  List<Object> get props => [dates, infoText];
}

class TrialDayRegistrationFailureState extends TrialDayRegistrationState {
  final List<DateTime> dates;
  final String infoText;
  final String errorMessage;

  const TrialDayRegistrationFailureState(
      {required this.dates, required this.infoText, required this.errorMessage})
      : super();

  @override
  List<Object> get props => [dates, infoText, errorMessage];
}

class TrialDayRegistrationLoadingErrorState extends TrialDayRegistrationState {
  final String errorMessage;

  const TrialDayRegistrationLoadingErrorState({required this.errorMessage})
      : super();

  @override
  List<Object> get props => [errorMessage];
}
