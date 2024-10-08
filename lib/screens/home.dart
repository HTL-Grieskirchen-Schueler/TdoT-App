import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdot_gkr/screens/navigation.dart';
import '../widgets/activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // SVG Wave Image
                    SvgPicture.asset(
                      "assets/wave.svg",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
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
