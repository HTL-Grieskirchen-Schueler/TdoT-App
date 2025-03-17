import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../models/trial_day_registration.model.dart';
import '../widgets/registration_form.dart';

class TrialDayRegistrationScreen extends StatefulWidget {
  const TrialDayRegistrationScreen({super.key});

  @override
  TrialDayRegistrationScreenState createState() =>
      TrialDayRegistrationScreenState();
}

class TrialDayRegistrationScreenState
    extends State<TrialDayRegistrationScreen> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocProvider(
          create: (context) =>
              TrialDayRegistrationBloc()..add(InitializeEvent()),
          child: CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text("Schnuppertag Anmeldung"),
            ),
            child: SafeArea(
              child: BlocListener<TrialDayRegistrationBloc,
                  TrialDayRegistrationState>(
                listener: (context, state) {
                  if (state is TrialDayRegistrationLoadingErrorState) {
                    _showToast(
                      state.errorMessage,
                      CupertinoColors.destructiveRed,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: BlocBuilder<TrialDayRegistrationBloc,
                    TrialDayRegistrationState>(
                  builder: (context, state) {
                    if (state is TrialDayRegistrationInitializedState) {
                      final currentState = state as dynamic;
                      return RegistrationForm(
                        dates: currentState.dates,
                        infoText: currentState.infoText,
                        onSubmit: (TrialDayRegistration registration) {
                          setState(() {
                            _isSubmitting = true;
                          });
                          context.read<TrialDayRegistrationBloc>().add(
                                RegisterEvent(
                                  registration: registration,
                                  onSuccess: () {
                                    _showToast(
                                      "Anmeldung erfolgreich!",
                                      CupertinoColors.activeGreen,
                                      toastLength: Toast.LENGTH_LONG,
                                    );

                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                  },
                                  onError: (String errorMessage) {
                                    _showToast(
                                      errorMessage,
                                      CupertinoColors.destructiveRed,
                                    );

                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                  },
                                ),
                              );
                        },
                      );
                    } else {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 32,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        if (_isSubmitting)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: CupertinoColors.black.withValues(alpha: 0.5),
            child: const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
                color: CupertinoColors.white,
              ),
            ),
          ),
      ],
    );
  }

  void _showToast(
    String message,
    Color backgroundColor, {
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: CupertinoColors.white,
      fontSize: 16.0,
    );
  }
}
