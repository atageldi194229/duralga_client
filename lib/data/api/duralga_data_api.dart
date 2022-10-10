import 'package:duralga_client/data/api/api_client.dart';

class DuralgaDataApi {
  ApiLoader getData() => ApiLoader(
        path: "/api/duralga/data",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getStopArrivalTimes(int stopId) => ApiLoader(
        path: "/api/arrival/stop/$stopId",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getStopArrivalTimes2(int stopId) => ApiLoader(
        path: "/api/arrival/stop2/$stopId",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getStopArrivalTimes3(int stopId) => ApiLoader(
        path: "/api/arrival/stop3/$stopId",
        loader: (path) => ApiClient().dio.get(path),
      );

  ApiLoader getRouteBusCollection(int routeNumber) => ApiLoader(
        path: "/api/routes/buses2/$routeNumber",
        loader: (path) => ApiClient().dio.get(path),
      );
}
