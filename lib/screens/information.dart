import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tdot_gkr/blocs/information/information_bloc.dart';
import 'package:tdot_gkr/widgets/divider.dart';

import '../widgets/text_section.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InformationBloc()..add(InitializeEvent()),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Schulanmeldung"),
        ),
        child: SafeArea(
          child: BlocListener<InformationBloc, InformationState>(
            listener: (context, state) {
              if (state is InformationLoadingErrorState) {
                _showToast(state.errorMessage, CupertinoColors.destructiveRed);
                Navigator.of(context).pop();
              }
            },
            child: BlocBuilder<InformationBloc, InformationState>(
              builder: (context, state) {
                if (state is InformationInitializedState) {
                  final currentState = state as dynamic;
                  return SingleChildScrollView(
                    child: Column(
                      children:
                          currentState.infoSections.map<Widget>((section) {
                        return Column(
                          children: [
                            TextSectionWidget(section: section),
                            if (currentState.infoSections.last != section)
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              },
            ),
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
      textColor: CupertinoColors.white,
      fontSize: 16.0,
    );
  }
}
