import 'package:duralga_client/data/api/api_client.dart';

class DuralgaDataApi {
  Future<dynamic> getData() async {
    var response = await ApiClient.instance().dio.get(":3051/api/duralga/data");
    return response.data;
  }
}
