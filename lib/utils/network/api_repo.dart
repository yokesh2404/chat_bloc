import 'package:dio/dio.dart';
import 'package:state_management/utils/helper/error_config.dart';
import 'package:state_management/utils/network/dio_client.dart';
import 'package:state_management/utils/network/dio_exception.dart';

class ApiRepo {
  final DioClient dioClient;

  ApiRepo({required this.dioClient});

  Future getData(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? headerOption,
  }) async {
    try {
      var options = await getOptions();

      var response = await dioClient.dio.get(path,
          queryParameters: queryParameters,
          options: headerOption ?? Options(headers: options));

      return getResponse(body: response.data, header: response.headers.map);
    } catch (e) {
      return handleException(e);
    }
  }
}

Response handleException(dioException) {
  String errorCode = DioExceptions.fromDioError(dioException).toString();
  return getResponse(
      code: errorCode,
      header: {},
      body: {"message": ErrorConfig.errorMessageMap[errorCode] ?? errorCode});
}

Response<Object> getResponse(
    {dynamic body, String? code, Map<String, dynamic>? header}) {
  Map<String, String> headerJson = {};

  return Response(
    requestOptions: RequestOptions(),
    data: body,
    headers: Headers(),
    statusMessage: code ?? ErrorConfig.C008,
  );
}

Future<Map<String, String>> getOptions() async {
  try {
    return {
      'content-Type': 'application/json',
    };
  } catch (e) {
    return {
      'content-Type': 'application/json',
    };
  }
}
