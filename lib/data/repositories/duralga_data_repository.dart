import 'package:duralga_client/data/api/duralga_data_api.dart';
import 'package:duralga_client/data/models/duralga_data_model.dart';
import 'package:duralga_client/data/models/route_bus_collection_model.dart';
import 'package:duralga_client/data/models/stop_arrival_time_response_model.dart';
import 'package:duralga_client/data/models/stop_arrival_time_response_model_2.dart';
import 'package:duralga_client/data/storage/storage.dart';

class DuralgaDataRepository {
  Future<DuralgaDataModel> getData() async {
    final apiLoader = DuralgaDataApi().getData();

    final data = await Storage().getCachedOrLoad(apiLoader);

    return DuralgaDataModel.fromMap(data);
  }

  Future<StopArrivalTimeResponse> getStopArrivalTimes(int stopId) async {
    final apiLoader = DuralgaDataApi().getStopArrivalTimes(stopId);

    final data = await apiLoader.dataLoader();

    return StopArrivalTimeResponse.fromMap(data);
  }

  Future<StopArrivalTimeResponse2> getStopArrivalTimes2(int stopId) async {
    final apiLoader = DuralgaDataApi().getStopArrivalTimes2(stopId);

    final data = await apiLoader.dataLoader();

    return StopArrivalTimeResponse2.fromMap(data);
  }

  Future<RouteBusCollectionModel> getRouteBusCollection(int routeNumber) async {
    final apiLoader = DuralgaDataApi().getRouteBusCollection(routeNumber);

    final data = await apiLoader.dataLoader();

    return RouteBusCollectionModel.fromMap(data);
  }
}
