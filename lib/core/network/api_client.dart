import 'package:dio/dio.dart';
import 'package:dockflow_app/core/storage/authstorage.dart';

class ApiClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  ApiClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AuthStorage.readToken();

          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            print('error headers');
          }

          return handler.next(error);
        },
      ),
    );
  }
}
