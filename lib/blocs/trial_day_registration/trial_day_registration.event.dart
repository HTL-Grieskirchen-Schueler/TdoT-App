part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationEvent {
  const TrialDayRegistrationEvent();
}

class InitializeEvent extends TrialDayRegistrationEvent {}

class RegisterEvent extends TrialDayRegistrationEvent {
  final TrialDayRegistration registration;
  final void Function() onSuccess;
  final void Function(String) onError;

  RegisterEvent({
    required this.registration,
    required this.onSuccess,
    required this.onError,
  });
}