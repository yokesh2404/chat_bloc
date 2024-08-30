class ErrorConfig {
  ErrorConfig._();

  //Api call error
  static const noInternet = 'No internet available';
  static const cancelRequest = "Request to API server was cancelled";
  static const connectionTimeOut = "Connection timeout with API server";
  static const receiveTimeOut = "Receive timeout in connection with API server";
  static const sendTimeOut = "Send timeout in connection with API server";
  static const socketException = "Check your internet connection";
  static const unexpectedError = "Unexpected error occurred";
  static const unknownError = "Something went wrong";
  static const badResponse = "Bad response error";
  static const badRequest = "Bad request";
  static const unauthorized = "Unauthorized";
  static const forbidden = "Forbidden";
  static const notFound = "Not found";
  static const internalServerError = "Internal server error";
  static const badGateway = "Bad gateway";
  static const noDataFound = "No data found";

  static const errorMessageMap = {
    C001: noInternet,
    C002: unexpectedError,
    C003: cancelRequest,
    C004: connectionTimeOut,
    C005: receiveTimeOut,
    C006: badResponse,
    C007: sendTimeOut,
    C008: unknownError,
    C204: noDataFound,
    C400: badRequest,
    C401: unauthorized,
    C403: forbidden,
    C404: notFound,
    C500: internalServerError,
    C502: badGateway,
  };

  static const C001 = 'C001';
  static const C002 = 'C002';
  static const C003 = 'C003';
  static const C004 = 'C004';
  static const C005 = 'C005';
  static const C006 = 'C006';
  static const C007 = 'C007';
  static const C008 = 'C008';
  static const C204 = '204';
  static const C400 = '400';
  static const C401 = '401';
  static const C403 = '403';
  static const C404 = '404';
  static const C500 = '500';
  static const C502 = '502';
}
