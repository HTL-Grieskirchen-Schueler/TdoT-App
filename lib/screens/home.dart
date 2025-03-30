import 'package:flutter/cupertino.dart';
import 'package:tdot_gkr/widgets/activity_list.dart';
import 'package:tdot_gkr/widgets/wave_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/htlgkr_logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned(
                    top: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xE43FA9D3),
                            Color(0xFF003BA9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const WaveAnimation(),
                  const Padding(
                    padding: EdgeInsets.only(top: 80.0, bottom: 80.0),
                    child: ActivityList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
