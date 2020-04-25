import 'package:dio/dio.dart';

import 'model/user.dart';

class Service {
  Dio _dio;

  Dio _getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(baseUrl: 'https://api.github.com'),
      );
    }
    return _dio;
  }

  Future<Response<T>> _get<T>(String path) async {
    final dio = _getDio();
    return _performRequest<T>(
      dio.get(path),
    );
  }

  Future<Response<T>> _performRequest<T>(Future<Response<T>> request) async {
    try {
      final result = await request;
      return result;
    } on DioError catch (error) {
      throw Exception(error.response?.data['message']);
    }
  }

  Future<User> getUser(String login) async {
    final response = await _get(
      '/users/$login',
    );
    return User.fromMap(response.data);
  }
}