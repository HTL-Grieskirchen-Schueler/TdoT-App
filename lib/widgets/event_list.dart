import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/models/activity.model.dart';
import 'package:tdot_gkr/widgets/event.dart';

class EventListWidget extends StatelessWidget {
  final List<Activity> activities;

  const EventListWidget({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return EventWidget(
          name: activity.name,
          description: activity.description,
          onPressed: () {
            context.read<NavigationBloc>().add(StartNavigationEvent(activity.name));
            context.read<NavigationBloc>().add(ClosePanelEvent());
          },
        );
      },
    );
  }
}
