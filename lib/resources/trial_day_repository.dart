import 'package:tdot_gkr/models/trial_day_registration.model.dart';
import '../exceptions/http_not_ok_exception.dart';
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
  List<DateTime>? _cachedTrialDayDate;

  Future<String> getTrialDayInfo() async {
    if (_cachedTrialDayInfo != null) {
      return _cachedTrialDayInfo!;
    }

    _cachedTrialDayInfo = await _handleRequest(() async {
      var response = await _provider.getRequest(endpoint: '/text/info');
      return response.data;
    });

    return _cachedTrialDayInfo!;
  }

  Future<List<DateTime>> getTrialDayDate() async {
    if (_cachedTrialDayDate != null) {
      return _cachedTrialDayDate!;
    }

    var responseData = await _handleRequest(() async {
      var response = await _provider.getRequest(endpoint: '/trialdays');
      return response.data;
    });

    try {
      _cachedTrialDayDate = (responseData as List<dynamic>)
          .map((dateString) => DateTime.parse(dateString as String))
          .toList();
    } catch (e) {
      throw Exception(
          'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }

    return _cachedTrialDayDate!;
  }

  Future<void> registerForTrialDay(TrialDayRegistration registration) async {
    await _handleRequest(() async {
      await _provider.postRequest(
          endpoint: '/trialdays/registration', data: registration.toJson());
      return;
    });
  }

  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on HttpNotOkException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception(
          'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
  }
}
