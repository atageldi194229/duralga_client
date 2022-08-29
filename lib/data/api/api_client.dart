import 'package:dio/dio.dart';

final localhostOptions = BaseOptions(baseUrl: "http://localhost:3051");

class ApiClient {
  late final Dio dio;
  ApiClient._sharedInstance() : dio = Dio(localhostOptions);
  static final ApiClient _shared = ApiClient._sharedInstance();
  factory ApiClient.instance() => _shared;
}
