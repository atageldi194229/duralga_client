import 'package:duralga_client/data/api/duralga_data_api.dart';
import 'package:duralga_client/data/models/duralga_data_model.dart';
import 'package:duralga_client/data/storage/storage.dart';

class DuralgaDataRepository {
  Future<DuralgaDataModel> getData() async {
    final apiLoader = DuralgaDataApi().getData();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return DuralgaDataModel.fromMap(data);
  }
}
