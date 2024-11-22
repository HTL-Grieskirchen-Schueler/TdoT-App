import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../exceptions/http_not_ok_exception.dart';

class ApiProvider {
  final Dio _dio = Dio();
  static final String? url = dotenv.env['BASE_URL'];

  ApiProvider() {
    if (url == null) {
      throw Exception('No BASE_URL defined');
    }
    _dio.options.baseUrl = url!;
  }

  Future<Response> getRequest({required String endpoint}) async {
    final response = await _dio.get(endpoint);
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 299) {
      throw HttpNotOkException(response.statusCode!);
    }
    return response;
  }

  Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final response = await _dio.post(endpoint, data: data);
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 299) {
      throw HttpNotOkException(response.statusCode!);
    }
    return response;
  }
}
