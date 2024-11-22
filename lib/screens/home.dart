import 'package:flutter/material.dart';
import 'package:tdot_gkr/widgets/activity_list.dart';
import 'package:tdot_gkr/widgets/wave_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            // Logo Section
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
            // Main Content Section
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
                  const ActivityList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
