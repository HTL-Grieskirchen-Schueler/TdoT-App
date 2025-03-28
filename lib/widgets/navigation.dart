import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBodyWidget extends StatelessWidget {
  const NavigationBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.black, width: 2),
            ),
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 4.0,
              child: SvgPicture.asset(
                'assets/floor_plan.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
