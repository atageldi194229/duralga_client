import 'package:duralga_client/data/api/api_client.dart';

class DuralgaDataApi {
  ApiLoader getData() => ApiLoader(
        path: ":3051/api/duralga/data",
        loader: (path) => ApiClient().dio.get(path),
      );
}
