import 'package:tdot_gkr/models/trial_day_registration.model.dart';

import 'api_provider.dart';

class TrialDayRepository {
  final _provider = ApiProvider();

  Future<String> getTrialDayInfo() async {
    // try {
    //   //TODO: use the correct endpoint
    //   final response = await _provider.getRequest(endpoint: 'trialdays/info');
    //   if (response.statusCode == null ||
    //       response.statusCode! < 200 ||
    //       response.statusCode! > 299) {
    //     throw Exception(
    //         "Fehlerhafte Antwort vom Server: ${response.statusCode}");
    //   }
    //   return response.data;
    // } catch (e) {
    //   throw Exception(
    //       "Während des Abrufs der Informationen ist ein Fehler aufgetreten. Bitte versuchen Sie es später erneut.");
    // }

    await Future.delayed(const Duration(seconds: 1));

    return "Test";
  }

  Future<void> registerForTrialDay(TrialDayRegistration registration) async {
    try {
      final response = await _provider.postRequest(
          endpoint: 'trialdays/registration', data: registration.toJson());
      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! > 299) {
        throw Exception(
            "Fehlerhafte Antwort vom Server: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(
          "Während der Registrierung ist ein Fehler aufgetreten. Bitte versuchen Sie es später erneut.");
    }
  }
}
