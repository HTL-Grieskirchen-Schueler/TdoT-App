part of 'trial_day_registration.bloc.dart';

abstract class TrialDayRegistrationState {
  final String school;
  final String name;
  final String email;
  final String phone;

  const TrialDayRegistrationState({
    this.school = '',
    this.name = '',
    this.email = '',
    this.phone = '',
  });
}

class TrialDayRegistrationLoading extends TrialDayRegistrationState {}

class TrialDayRegistrationLoaded extends TrialDayRegistrationState {
  final DateTime nextTrialDay;

  TrialDayRegistrationLoaded(this.nextTrialDay);
}

class TrialDayRegistrationLoadingError extends TrialDayRegistrationState {
  final String message;

  TrialDayRegistrationLoadingError(this.message);
}

class TrialDayRegistrationRegistering extends TrialDayRegistrationState {}

class TrialDayRegistrationRegistered extends TrialDayRegistrationState {
  final TrialDayRegistration registration;

  TrialDayRegistrationRegistered(this.registration);
}

class TrialDayRegistrationError extends TrialDayRegistrationState {
  final String message;

  TrialDayRegistrationError(this.message);
}
