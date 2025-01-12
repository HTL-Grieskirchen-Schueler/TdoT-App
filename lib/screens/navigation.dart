import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tdot_gkr/models/activity.model.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';
import 'package:tdot_gkr/widgets/event_list.dart';
import 'package:tdot_gkr/widgets/navigation.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();
    const double tabBarHeight = 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wegweiser'),
      ),
      body: SlidingUpPanel(
        controller: panelController,
        maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
        panelBuilder: (scrollController) => buildSlidingPanel(scrollController),
        body: const NavigationBodyWidget(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget buildSlidingPanel(ScrollController scrollController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: buildDragIcon(),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Events',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          child: FutureBuilder<List<Activity>>(
            future: NavigationRepository().getActivities(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    snapshot.error.toString().substring(11),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Keine Events verfügbar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              final activities = snapshot.data!;
              return EventListWidget(activities: activities);
            },
          ),
        ),
      ],
    );
  }

  Widget buildDragIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 40,
      height: 8,
    );
  }
}