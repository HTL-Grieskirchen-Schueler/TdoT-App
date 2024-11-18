part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationEvent {
  const TrialDayRegistrationEvent();
}

class InitializeEvent extends TrialDayRegistrationEvent {}

class RegisterEvent extends TrialDayRegistrationEvent {
  final TrialDayRegistration registration;

  RegisterEvent({
    required this.registration,
  });
}

class ToastCompleteEvent extends TrialDayRegistrationEvent {}
