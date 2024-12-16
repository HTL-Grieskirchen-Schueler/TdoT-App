import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tdot_gkr/blocs/information/information_bloc.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InformationBloc()..add(InitializeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Schulanmeldung"),
        ),
        body: BlocListener<InformationBloc, InformationState>(
          listener: (context, state) {
            if (state is InformationLoadingErrorState) {
              _showToast(state.errorMessage, Colors.red);
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<InformationBloc, InformationState>(
            builder: (context, state) {
              if (state is InformationInitializedState) {
                final currentState = state as dynamic;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(currentState.infoText),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
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
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
