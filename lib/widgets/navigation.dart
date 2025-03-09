import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';

class NavigationBodyWidget extends StatefulWidget {
  const NavigationBodyWidget({super.key});

  @override
  NavigationBodyWidgetState createState() => NavigationBodyWidgetState();
}

class NavigationBodyWidgetState extends State<NavigationBodyWidget> {
  int _selectedFloor = 0;

  @override
  void initState() {
    super.initState();
    // Fetch the SVG for the initial floor when the widget is first loaded
    context.read<NavigationBloc>().add(FetchSvgEvent(_selectedFloor));
    context.read<NavigationBloc>().add(const PositionChangedEvent(100, 100, 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        // Handle state changes if needed
      },
      builder: (context, state) {
        return Column(
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
                          // Fetch the SVG for the new floor
                          context.read<NavigationBloc>().add(FetchSvgEvent(newFloor));
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
                child: _buildSvgView(state),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSvgView(NavigationState state) {
    if (state is PositionUpdated) {
      // Display the updated SVG with the red dot
      return InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 5.0,
        child: SvgPicture.string(
          state.svgData,
          fit: BoxFit.contain,
        ),
      );
    } else if (state is SvgUpdated) {
      // Display the SVG without the red dot
      return InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 5.0,
        child: SvgPicture.string(
          state.svgData,
          fit: BoxFit.contain,
        ),
      );
    } else if (state is NavigationInitial) {
      // Display a loading indicator while waiting for the initial SVG
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: Text('Waiting for position update...'));
    }
  }
}