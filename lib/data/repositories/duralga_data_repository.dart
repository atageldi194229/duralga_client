import 'package:duralga_client/data/api/duralga_data_api.dart';
import 'package:duralga_client/data/models/duralga_data_model.dart';

class DuralgaDataRepository {
  Future<DuralgaDataModel> getData() async {
    final data = await DuralgaDataApi().getData();
    return DuralgaDataModel.fromMap(data);
  }
}
