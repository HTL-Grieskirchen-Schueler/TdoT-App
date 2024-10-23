import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = dotenv.env['BASE_URL']!;

  Future<Response> getRequest({required String endpoint}) async {
    try {
      final response = await _dio.get('$_url/$endpoint');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post('$_url/$endpoint', data: data);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
