import 'package:duralga_client/data/api/api_client.dart';

class DuralgaDataApi {
  ApiLoader getData() => ApiLoader(
        path: ":3051/api/duralga/data",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getStopArrivalTimes(int stopId) => ApiLoader(
        path: ":3051/api/arrival/stop/$stopId",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getStopArrivalTimes2(int stopId) => ApiLoader(
        path: ":3051/api/arrival/stop2/$stopId",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getRouteBusCollection(int routeNumber) => ApiLoader(
        path: ":3051/api/routes/buses2/$routeNumber",
        loader: (path) => ApiClient().dio.get(path),
      );
}
