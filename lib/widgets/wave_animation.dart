import 'package:flutter/cupertino.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:simple_animations/simple_animations.dart';

class WaveAnimation extends StatelessWidget {
  const WaveAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          for (var i in [
            [6, 15.0, 1.0],
            [4, 7.5, 0.5],
            [3, 0.0, 0.3],
          ])
            LoopAnimationBuilder<double>(
              tween: Tween(
                begin: -200,
                end: 0,
              ),
              duration: Duration(seconds: i[0] as int),
              builder: (context, value, child) => Positioned(
                left: value,
                top: -i[1] as double,
                child: Container(
                  width: MediaQuery.of(context).size.width + 200,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: const Svg(
                        "assets/wave.svg",
                      ),
                      colorFilter: ColorFilter.mode(
                        CupertinoColors.white.withValues(
                          alpha: i[2] as double,
                        ),
                        BlendMode.srcIn,
                      ),
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
