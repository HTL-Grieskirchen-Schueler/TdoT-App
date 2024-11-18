import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tdot_gkr/screens/trial_day_registration.dart';
import '../widgets/activity.dart';
import 'navigation.dart';

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
                  SizedBox(
                    height: 100,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        for (var i in [
                          [6, 15.0, 1.0],
                          [4, 7.5, 0.5],
                          [3, 0.0, 0.3]
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
                                      Colors.white.withOpacity(
                                        i[2] as double,
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
                  ),
                  Column(
                    children: <Widget>[
                      // Activity Section
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 180.0, top: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ActivityWidget(
                                title: "Wegweiser",
                                description:
                                    "lorem lorem lorem lorem lorem lorem",
                                iconData: Icons.map,
                                onTap: () => _navigateTo(
                                  context,
                                  const NavigationScreen(),
                                ),
                              ),
                              ActivityWidget(
                                title: "Anmelden",
                                description: "Option 2",
                                iconData: Icons.school,
                                onTap: () => _navigateTo(context,
                                    const TrialDayRegistrationScreen()),
                              ),
                              ActivityWidget(
                                title: "Infos",
                                description: "Option 3",
                                iconData: Icons.info,
                                onTap: () => print("Option 3 tapped"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
