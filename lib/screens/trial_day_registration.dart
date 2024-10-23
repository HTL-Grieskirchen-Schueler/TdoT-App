import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../widgets/registration_form.dart';

class TrialDayRegistrationScreen extends StatelessWidget {
  const TrialDayRegistrationScreen({super.key});

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrialDayRegistrationBloc()..add(InitializeEvent()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<TrialDayRegistrationBloc, TrialDayRegistrationState>(
          listener: (context, state) {
            if (state is TrialDayRegistrationSuccessState) {
              _showToast("Anmeldung erfolgreich!", Colors.green);
            } else if (state is TrialDayRegistrationFailureState) {
              _showToast(state.errorMessage, Colors.red);
            } else if (state is TrialDayRegistrationLoadingErrorState) {
              _showToast(state.errorMessage, Colors.red);
              Navigator.of(context).pop();
            }
          },
          child:
              BlocBuilder<TrialDayRegistrationBloc, TrialDayRegistrationState>(
            builder: (context, state) {
              if (state is TrialDayRegistrationInitializedState ||
                  state is TrialDayRegistrationSuccessState ||
                  state is TrialDayRegistrationFailureState) {
                return const RegistrationForm();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
