import 'package:flutter/material.dart';

import '../screens/information.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ActivityWidget(
          title: "Wegweiser",
          description: "Wir bringen dich an dein Ziel!",
          iconData: Icons.map,
          onTap: () => _navigateTo(
            context,
            const NavigationScreen(),
          ),
        ),
        ActivityWidget(
          title: "Schnuppertag",
          description: "Tauche in den HTL-Alltag ein!",
          iconData: Icons.history_edu,
          onTap: () => _navigateTo(context, const TrialDayRegistrationScreen()),
        ),
        ActivityWidget(
          title: "Schulanmeldung",
          description: "Melde dich jetzt an!",
          iconData: Icons.school,
          onTap: () => _navigateTo(context, const InformationScreen()),
        ),
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
