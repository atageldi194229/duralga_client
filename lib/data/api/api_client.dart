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
  factory ApiClient() => _shared;
}

class ApiLoader {
  final String path;
  late Future<Response> Function() loader;

  ApiLoader({
    required this.path,
    required Future<Response> Function(String path) loader,
  }) {
    this.loader = () => loader(path);
  }
}
