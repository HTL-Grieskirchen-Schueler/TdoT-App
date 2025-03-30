import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';
import 'dart:math' as math;
import 'dart:async';

class NavigationBodyWidget extends StatefulWidget {
  const NavigationBodyWidget({super.key});

  @override
  NavigationBodyWidgetState createState() => NavigationBodyWidgetState();
}

class NavigationBodyWidgetState extends State<NavigationBodyWidget> {
  int _selectedFloor = 0;
  final int _currentX = 120;
  final int _currentY = 350;
  Timer? _positionTimer;

  @override
  void initState() {
    super.initState();
    context.read<NavigationBloc>().add(FetchSvgEvent(_selectedFloor));
    context.read<NavigationBloc>().add(PositionChangedEvent(_currentX, _currentY, _selectedFloor));

    // Start the position simulation
    //_startPositionSimulation();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _positionTimer?.cancel();
    super.dispose();
  }

  // void _startPositionSimulation() {
  //   _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     // Update the position slightly
  //     setState(() {
  //       _currentX += (math.Random().nextInt(21) - 20); // Random change between -10 and 10
  //       _currentY += (math.Random().nextInt(21) - 20); // Random change between -10 and 10
  //     });

  //     // Dispatch the PositionChangedEvent to update the SVG
  //     context.read<NavigationBloc>().add(PositionChangedEvent(_currentX, _currentY, _selectedFloor));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: _buildSvgView(state),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSvgView(NavigationState state) {
  if (state is PositionUpdated || state is SvgUpdated) {
    return Transform.rotate(
      angle: -math.pi / 2,
      child: Transform.scale(
        scale: 1.7,
        child: SvgPicture.string(
          state is PositionUpdated ? state.svgData : (state as SvgUpdated).svgData,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (state is NavigationInitial) {
    return const Center(child: CircularProgressIndicator());
  } else {
    return const Center(child: Text('Waiting for position update...'));
  }
}
}