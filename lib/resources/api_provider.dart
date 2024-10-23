import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/trial_day_registration.model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = dotenv.env['BASE_URL']!;

  Future<TrialDayRegistration> postTrialDayRegistration(
      Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post('$_url/registrations', data: data);
      return TrialDayRegistration.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<DateTime> getNextTrialDay() async {
    try {
      Response response = await _dio.get('$_url/next-trial-day');
      return DateTime.parse(response.data['nextTrialDay']);
    } catch (error) {
      rethrow;
    }
  }
}
