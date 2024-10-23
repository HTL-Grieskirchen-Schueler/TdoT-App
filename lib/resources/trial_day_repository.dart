import 'package:tdot_gkr/models/trial_day_registration.model.dart';

import 'api_provider.dart';

class TrialDayRepository {
  final _provider = ApiProvider();

  Future<DateTime> getNextTrialDay() {
    return _provider.getRequest(endpoint: 'trial-day').then((response) {
      return DateTime.parse(response.data['date']);
    });
  }

  Future<void> registerForTrialDay(TrialDayRegistration registration) async {
    try {
      final response = await _provider.postRequest(
          endpoint: 'trial-day/registrations', data: registration.toJson());
      if (response.statusCode != 200) {
        throw Exception("Fehler von resposne");
      }
    } catch (e) {
      throw Exception("Während der Anmeldung ist ein Fehler aufgetreten");
    }
  }
}
