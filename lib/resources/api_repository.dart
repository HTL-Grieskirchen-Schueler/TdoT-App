import 'package:tdot_gkr/models/trial_day_registration.model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TrialDayRegistration> postTrialDayRegistration(
      TrialDayRegistration registration) {
    return _provider.postTrialDayRegistration(registration.toJson());
  }

  Future<DateTime> getNextTrialDay() {
    return _provider.getNextTrialDay();
  }
}

class NetworkError extends Error {}
