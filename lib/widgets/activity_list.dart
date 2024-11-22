import 'package:flutter/material.dart';

import '../screens/navigation.dart';
import '../screens/trial_day_registration.dart';
import 'activity.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 80),
        // Activity Section
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ActivityWidget(
                title: "Wegweiser",
                description: "lorem lorem lorem lorem lorem lorem",
                iconData: Icons.map,
                onTap: () => _navigateTo(
                  context,
                  const NavigationScreen(),
                ),
              ),
              ActivityWidget(
                title: "Anmelden",
                description: "Melden Sie sich für einen Schnuppertag an",
                iconData: Icons.school,
                onTap: () =>
                    _navigateTo(context, const TrialDayRegistrationScreen()),
              ),
              ActivityWidget(
                title: "Infos",
                description: "Wichtige Informationen zum Aufnahmeverfahren",
                iconData: Icons.info,
                onTap: () => print("Option 3 tapped"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
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
