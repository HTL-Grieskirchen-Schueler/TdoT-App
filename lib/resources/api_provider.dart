import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  final Dio _dio = Dio();
  static final String? url = dotenv.env['BASE_URL'];

  ApiProvider() {
    if (url == null) {
      throw Exception('No BASE_URL defined');
    }
    _dio.options.baseUrl = url!;
    _dio.options.validateStatus = (_) => true;
  }

  Future<Response> getRequest({required String endpoint}) async {
    final response = await _dio.get(endpoint);
    if (response.statusCode != null &&
        (response.statusCode! < 200 || response.statusCode! > 299)) {
      if (response.data != null && response.data['detail'] != null) {
        throw Exception(response.data['detail']);
      }
      throw Exception(
          'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
    return response;
  }

  Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final response = await _dio.post(endpoint, data: data);
    if (response.statusCode != null &&
        (response.statusCode! < 200 || response.statusCode! > 299)) {
      if (response.data != null && response.data['detail'] != null) {
        throw Exception(response.data['detail']);
      }
      throw Exception(
          'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
    return response;
  }
}
