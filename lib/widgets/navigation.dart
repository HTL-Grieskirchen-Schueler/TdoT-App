// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tdot_gkr/resources/navigation_repository.dart';

// class NavigationBodyWidget extends StatelessWidget {
//   const NavigationBodyWidget({super.key});

  

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.height * 0.7,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 2),
//             ),
//             child: InteractiveViewer(
//               boundaryMargin: const EdgeInsets.all(100),
//               minScale: 0.5,
//               maxScale: 4.0,
//               child: SvgPicture.string(
//                 NavigationRepository().getSvg(0).toString(),
//                 fit: BoxFit.contain,
//               ),
//               // child: SvgPicture.asset(
//               //   'assets/floorplan_eg.svg',
//               //   fit: BoxFit.contain,
//               // ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/resources/navigation_repository.dart';

class NavigationBodyWidget extends StatefulWidget {
  const NavigationBodyWidget({super.key});

  @override
  _NavigationBodyWidgetState createState() => _NavigationBodyWidgetState();
}

class _NavigationBodyWidgetState extends State<NavigationBodyWidget> {
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

  @override
  Widget build(BuildContext context) {
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
                    DropdownMenuItem(value: 0, child: Text('Unten')),
                    DropdownMenuItem(value: 1, child: Text('Oben')),
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
      ],
    );
  }
}
