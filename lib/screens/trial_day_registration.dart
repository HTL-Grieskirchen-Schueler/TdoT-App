import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../models/trial_day_registration.model.dart';
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

    //Toast.LENGTH_SHORT is 1 second long
    Future.delayed(const Duration(seconds: 1), () {
      TrialDayRegistrationBloc().add(ToastCompleteEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrialDayRegistrationBloc()..add(InitializeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Schnuppertag Anmeldung"),
        ),
        body: BlocListener<TrialDayRegistrationBloc, TrialDayRegistrationState>(
          listener: (context, state) {
            if (state is TrialDayRegistrationLoadingErrorState) {
              _showToast(state.errorMessage, Colors.red);
              Navigator.of(context).pop();
            }
          },
          child:
              BlocBuilder<TrialDayRegistrationBloc, TrialDayRegistrationState>(
            builder: (context, state) {
              if (state is TrialDayRegistrationInitializedState) {
                final currentState = state as dynamic;
                return RegistrationForm(
                  dates: currentState.dates,
                  infoText: currentState.infoText,
                  onSubmit: (TrialDayRegistration registration) {
                    context.read<TrialDayRegistrationBloc>().add(
                          RegisterEvent(
                              registration: registration,
                              onSuccess: () => _showToast(
                                  "Anmeldung erfolgreich!", Colors.green),
                              onError: (String? message) => _showToast(
                                  message ??
                                      "Etwas ist falsch gelaufen. Bitte versuchen Sie es später erneut.",
                                  Colors.red)),
                        );
                  },
                );
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
