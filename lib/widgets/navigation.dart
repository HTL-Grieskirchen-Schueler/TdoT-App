import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';

class NavigationBodyWidget extends StatefulWidget {
  const NavigationBodyWidget({super.key});

  @override
  NavigationBodyWidgetState createState() => NavigationBodyWidgetState();
}

class NavigationBodyWidgetState extends State<NavigationBodyWidget> {
  late Future<String> _svgFuture;
  int _selectedFloor = 0;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  void _loadSvg() {
    setState(() {
      _svgFuture = NavigationRepository().getSvg(_selectedFloor);
    });
  }

  void _startNavigation(String eventName) {
    context.read<NavigationBloc>().add(StartNavigationEvent(eventName, _selectedFloor));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is SvgUpdated) {
            setState(() {
              _svgFuture = Future.value(state.svgData);
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButton<int>(
                      value: _selectedFloor,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      underline: const SizedBox(),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('EG')),
                        DropdownMenuItem(value: 1, child: Text('OG')),
                      ],
                      onChanged: (newFloor) {
                        if (newFloor != null) {
                          setState(() {
                            _selectedFloor = newFloor;
                          });
                          _loadSvg();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: FutureBuilder<String>(
                  future: _svgFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.'),
                      );
                    } else if (snapshot.hasData) {
                      return InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(100),
                        minScale: 0.5,
                        maxScale: 5.0,
                        child: SvgPicture.string(
                          snapshot.data!,
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      return const Center(child: Text('Keine Daten verfügbar.'));
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _startNavigation("e15"), // Example event
              child: const Text("Navigate to e15"),
            ),
          ],
        ),
      ),
    );
  }
}
