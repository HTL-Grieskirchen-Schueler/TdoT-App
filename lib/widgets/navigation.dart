import 'dart:async'; // For Timer
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_bloc.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_event.dart';
import 'package:tdot_gkr/blocs/navigation/navigation_state.dart';
import 'dart:math' as math;

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
    _loadSvgData(_selectedFloor);
    context
        .read<NavigationBloc>()
        .add(PositionChangedEvent(_currentX, _currentY, _selectedFloor));
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    super.dispose();
  }

  void _loadSvgData(int floor) async {
    try {
      setState(() {});
    } catch (e) {
      print('Failed to load SVG: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CupertinoSlidingSegmentedControl<int>(
            groupValue: _selectedFloor,
            onValueChanged: (int? newFloor) {
              if (newFloor != null) {
                setState(() {
                  _selectedFloor = newFloor;
                });
                _loadSvgData(newFloor);
                context.read<NavigationBloc>().add(
                      PositionChangedEvent(
                        _currentX,
                        _currentY,
                        _selectedFloor,
                      ),
                    );
              }
            },
            children: const <int, Widget>{
              0: Text('EG', style: TextStyle(fontSize: 16.0)),
              1: Text('OG', style: TextStyle(fontSize: 16.0)),
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200.0),
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, state) {
                if (state is SvgUpdated) {
                  return Transform.rotate(
                    angle: -math.pi / 2,
                    child: Transform.scale(
                      scale: 1.6,
                      child: SvgPicture.string(
                        state.svgData,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
