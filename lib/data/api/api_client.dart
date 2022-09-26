import 'package:dio/dio.dart';

final localOptions = BaseOptions(
  baseUrl: "http://localhost",
);

final local1Options = BaseOptions(
  baseUrl: "http://192.168.1.12",
);

final imdatOptions = BaseOptions(
  baseUrl: "http://duralga.imdatelektronika.com",
  sendTimeout: 30 * 1000,
  receiveTimeout: 30 * 1000,
);

class ApiClient {
  late final Dio dio;
  ApiClient._sharedInstance() : dio = Dio(localOptions);
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

  Future<dynamic> dataLoader() => loader().then((res) => res.data);
}
