import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

class ActivityWidget extends StatefulWidget {
  final String title;
  final String description;
  final IconData iconData;
  final VoidCallback onTap;

  const ActivityWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
    required this.onTap,
  });

  @override
  ActivityWidgetState createState() => ActivityWidgetState();
}

class ActivityWidgetState extends State<ActivityWidget> {
  double _scale = 1.0; // Control scaling factor

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95; // Scale down slightly
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // Reset scale
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // Reset scale
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row(
            children: [
              Icon(
                widget.iconData,
                size: 50,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.arrow_forward_ios,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
