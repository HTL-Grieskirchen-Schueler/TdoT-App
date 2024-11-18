import 'package:tdot_gkr/models/trial_day_registration.model.dart';
import '../exceptions/http_not_ok_exception.dart';
import 'api_provider.dart';

class TrialDayRepository {
  final _provider = ApiProvider();
  String? _cachedTrialDayInfo;
  List<DateTime>? _cachedTrialDayDate;

  Future<String> getTrialDayInfo() async {
    if (_cachedTrialDayInfo != null) {
      return _cachedTrialDayInfo!;
    }

    // _cachedTrialDayInfo = await _handleRequest(() async {
    //   var response = await _provider.getRequest(endpoint: 'trialdays/info');
    //   return response.data['info'];
    // });

    await Future.delayed(const Duration(seconds: 1));
    _cachedTrialDayInfo = 'Test Info';

    return _cachedTrialDayInfo!;
  }

  Future<List<DateTime>> getTrialDayDate() async {
    if (_cachedTrialDayDate != null) {
      return _cachedTrialDayDate!;
    }

    // _cachedTrialDayDate = await _handleRequest(() async {
    //   var response = await _provider.getRequest(endpoint: 'trialdays/date');
    //   return response.data;
    // });

    await Future.delayed(const Duration(seconds: 1));
    _cachedTrialDayDate = [
      DateTime(2023, 10, 1),
      DateTime(2023, 11, 15),
      DateTime(2023, 12, 20),
    ];

    return _cachedTrialDayDate!;
  }

  Future<void> registerForTrialDay(TrialDayRegistration registration) async {
    await _handleRequest(() async {
      await _provider.postRequest(
          endpoint: 'trialdays/registration', data: registration.toJson());
      return null;
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
