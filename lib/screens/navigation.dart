import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';
import 'package:tdot_gkr/models/activity.model.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';
import 'package:tdot_gkr/widgets/event_list.dart';
import 'package:tdot_gkr/widgets/navigation.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();

    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wegweiser'),
        ),
        body: BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state is PanelClosed) {
              panelController.close();
            }
          },
          child: SlidingUpPanel(
            controller: panelController,
            maxHeight: MediaQuery.of(context).size.height - 80,
            panelBuilder: (scrollController) =>
                buildSlidingPanel(scrollController, panelController),
            body: const NavigationBodyWidget(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSlidingPanel(ScrollController scrollController, PanelController panelController) {
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
              return EventListWidget(activities: snapshot.data!);
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
