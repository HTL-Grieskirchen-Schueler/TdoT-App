import 'package:tdot_gkr/models/trial_day_registration.model.dart';
import 'api_provider.dart';

class TrialDayRepository {
  TrialDayRepository._privateConstructor();

  static final TrialDayRepository _instance =
      TrialDayRepository._privateConstructor();

  factory TrialDayRepository() {
    return _instance;
  }

  final _provider = ApiProvider();
  String? _cachedTrialDayInfo;

  Future<String> getTrialDayInfo() async {
    if (_cachedTrialDayInfo != null) {
      return _cachedTrialDayInfo!;
    }

    var response = await _provider.getRequest(endpoint: '/text/info');
    _cachedTrialDayInfo = response.data;

    return _cachedTrialDayInfo!;
  }

  Future<List<DateTime>> getTrialDayDate() async {
    var response = await _provider.getRequest(endpoint: '/trialdays');
    var responseData = response.data;

    try {
      return (responseData as List<dynamic>)
          .map((dateString) => DateTime.parse(dateString as String))
          .toList();
    } catch (e) {
      throw Exception(
          'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
  }

  Future<void> registerForTrialDay(TrialDayRegistration registration) async {
    await _provider.postRequest(
        endpoint: '/trialdays/registration', data: registration.toJson());
  }
}
