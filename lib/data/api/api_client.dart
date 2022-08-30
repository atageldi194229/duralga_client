import 'package:dio/dio.dart';

final localhostOptions = BaseOptions(
  baseUrl: "http://localhost",
);

final imdatOptions = BaseOptions(
  baseUrl: "http://duralga.imdatelektronika.com",
);

class ApiClient {
  late final Dio dio;
  ApiClient._sharedInstance() : dio = Dio(imdatOptions);
  static final ApiClient _shared = ApiClient._sharedInstance();
  factory ApiClient.instance() => _shared;
}
