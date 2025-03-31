import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';
import 'package:tdot_gkr/models/event.model.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';
import 'package:tdot_gkr/widgets/event.dart';
import 'package:tdot_gkr/widgets/navigation.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final PanelController _panelController = PanelController();
  late Future<List<Event>> _activitiesFuture;
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    _activitiesFuture = NavigationRepository().getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NavigationRepository(),
      child: BlocProvider(
        create: (context) =>
            NavigationBloc(context.read<NavigationRepository>()),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Wegweiser'),
          ),
          child: SafeArea(
            child: BlocListener<NavigationBloc, NavigationState>(
              listener: (context, state) {
                if (state is PanelClosed) {
                  _panelController.close();
                }
              },
              child: SlidingUpPanel(
                controller: _panelController,
                maxHeight: MediaQuery.of(context).size.height,
                panelBuilder: (scrollController) =>
                    buildSlidingPanel(scrollController, _panelController),
                body: const NavigationBodyWidget(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSlidingPanel(
      ScrollController scrollController, PanelController panelController) {
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
        Expanded(
          child: FutureBuilder<List<Event>>(
            future: _activitiesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    snapshot.error.toString().substring(11),
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemRed,
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
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                );
              }
              return ListView.builder(
                controller: scrollController,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final activity = snapshot.data![index];
                  return EventWidget(
                    name: activity.name,
                    description: activity.description,
                    onPressed: () {
                      context.read<NavigationBloc>().add(
                            StartNavigationEvent(
                              activity.room,
                            ),
                          );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDragIcon() {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 40,
      height: 8,
    );
  }
}
