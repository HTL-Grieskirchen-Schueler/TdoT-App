import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../exceptions/http_not_ok_exception.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = dotenv.env['BASE_URL']!;

  Future<Response> getRequest({required String endpoint}) async {
    final response = await _dio.get('$_url/$endpoint');
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 299) {
      throw HttpNotOkException(response.statusCode!);
    }
    return response;
  }

  Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final response = await _dio.post('$_url/$endpoint', data: data);
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! > 299) {
      throw HttpNotOkException(response.statusCode!);
    }
    return response;
  }
}
