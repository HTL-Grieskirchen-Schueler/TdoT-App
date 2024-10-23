part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationEvent {
  const TrialDayRegistrationEvent();
}

class Initialize extends TrialDayRegistrationEvent {}

class RegisterForTrialDay extends TrialDayRegistrationEvent {
  final TrialDayRegistration registration;

  RegisterForTrialDay({
    required this.registration,
  });
}
