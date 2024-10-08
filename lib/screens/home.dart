import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                    SvgPicture.asset(
                      "assets/wave.svg",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <ActivityWidget>[
                          ActivityWidget(
                            title: "Wegweiser",
                            description: "lorem lorem lorem lorem lorem lorem",
                            iconData: Icons.map,
                            onTap: () => print("Option 1 tapped"),
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
}
