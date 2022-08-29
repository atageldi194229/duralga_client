import 'package:duralga_client/data/api/api_client.dart';

class DuralgaDataApi {
  Future<dynamic> getData() async {
    var response = await ApiClient.instance().dio.get("/api/duralga/data");
    return response.data;
  }
}
