import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:simple_animations/simple_animations.dart';
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
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(63, 169, 211, 0.9),
                      Color(0xFF005BA9),
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          for (var i in [
                            [11, 1.0],
                            [7, 0.5],
                            [5, 0.3]
                          ])
                            LoopAnimationBuilder<double>(
                                tween: Tween(
                                    begin: -MediaQuery.of(context).size.width,
                                    end: 0),
                                duration: Duration(seconds: i[0] as int),
                                builder: (context, value, child) => Positioned(
                                      left: value,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                2,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: const Svg(
                                            "assets/wave.svg",
                                          ),
                                          colorFilter: ColorFilter.mode(
                                              Colors.white
                                                  .withOpacity(i[1] as double),
                                              BlendMode.srcIn),
                                          repeat: ImageRepeat.repeatX,
                                        )),
                                      ),
                                    )),
                        ],
                      ),
                    ),
                    // Activity Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 180.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ActivityWidget(
                              title: "Wegweiser",
                              description:
                                  "lorem lorem lorem lorem lorem lorem",
                              iconData: Icons.map,
                              onTap: () => _navigateTo(
                                  context, const NavigationScreen()),
                            ),
                            ActivityWidget(
                              title: "Anmelden",
                              description: "Option 2",
                              iconData: Icons.school,
                              onTap: () => print("Option 2 tapped"),
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
              ),
            ),
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
