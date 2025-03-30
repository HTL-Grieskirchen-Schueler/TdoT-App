import 'package:flutter/cupertino.dart';
import 'package:tdot_gkr/models/event.model.dart';
import 'package:tdot_gkr/widgets/event.dart';

class EventListWidget extends StatelessWidget {
  final List<Event> activities;

  const EventListWidget({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Events'),
      ),
      child: CupertinoScrollbar(
        child: SafeArea(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                },
                child: EventWidget(
                  name: activity.name,
                  description: activity.description,
                  onPressed: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
