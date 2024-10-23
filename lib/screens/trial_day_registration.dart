import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../widgets/registration_form.dart';

class TrialDayRegistrationScreen extends StatelessWidget {
  const TrialDayRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TrialDayRegistrationBloc()..add(Initialize()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<TrialDayRegistrationBloc, TrialDayRegistrationState>(
          builder: (context, state) {
            // if (state is TrialDayRegistrationLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // } else
            if (state is TrialDayRegistrationLoaded) {
              return RegistrationForm();
            } else if (state is TrialDayRegistrationRegistered) {
              return Center(
                child: Text(
                  'Registration successful for ${state.registration.name}!',
                  style: const TextStyle(fontSize: 24.0),
                ),
              );
            } else if (state is TrialDayRegistrationError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(fontSize: 24.0, color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
