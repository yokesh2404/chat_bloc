import 'package:dio/dio.dart';
import 'package:state_management/utils/network/api_client.dart';
import 'package:state_management/utils/network/dio_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = ""
      ..options.responseType = ResponseType.json
      ..options.connectTimeout = ApiClient.connectionTimeOut
      ..options.receiveTimeout = ApiClient.connectionTimeOut
      ..interceptors.add(DioInterceptor());
  }
}
