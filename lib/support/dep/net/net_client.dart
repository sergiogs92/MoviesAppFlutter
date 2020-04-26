import 'package:core/dep/net/net.dart';
import 'package:core/dep/net/net_client.dart';
import 'package:core/dep/result.dart';
import 'package:dio/dio.dart';

class AppNetClientBuilder implements NetClientBuilder {
  @override
  NetClient buildClient() => _DioNetClient();
}

class _DioNetClient implements NetClient {
  final Dio _dio = Dio();

  @override
  Future<Result<NetResponse, NetError>> request(NetRequest request) async {
    try {
      final response = await _dio.request(request.url,
          data: _toDioRequestData(request),
          options: _toDioRequestOptions(request));
      return Result.success(_toNetResponse(response));
    } catch (error) {
      return Result.failure(_toNetError(error));
    }
  }
}

String _toDioRequestData(NetRequest request) =>
    request.body.map((body) => body.content).or(() => null);

Options _toDioRequestOptions(NetRequest request) {
  final options = Options(
      method: _toDioRequestMethod(request.method),
      responseType: ResponseType.bytes);
  if (request.headers.isNotEmpty) {
    options.headers = request.headers;
  }
  request.body.ifValue((body) => options.contentType = body.contentType);
  return options;
}

// ignore: missing_return
String _toDioRequestMethod(NetRequestMethod method) {
  switch (method) {
    case NetRequestMethod.get:
      return "GET";
    case NetRequestMethod.head:
      return "HEAD";
    case NetRequestMethod.post:
      return "POST";
    case NetRequestMethod.put:
      return "PUT";
    case NetRequestMethod.patch:
      return "PATCH";
    case NetRequestMethod.delete:
      return "DELETE";
  }
}

NetResponse _toNetResponse(Response dioResponse) {
  return NetResponse(
      statusCode: dioResponse.statusCode,
      body: dioResponse.data,
      headers: _toNetResponseHeaders(dioResponse));
}

Map<String, String> _toNetResponseHeaders(Response dioResponse) =>
    dioResponse.headers.map
        .map((name, value) => MapEntry(name, value.join(",")));

NetError _toNetError(dynamic error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.CANCEL:
        return ConnectionErrorNetError(underlying: error);
      case DioErrorType.RESPONSE:
        return ErrorResponseNetError(
            response: _toNetResponse(error.response), underlying: error);
      case DioErrorType.DEFAULT:
        return GeneralNetError(message: "DioError", underlying: error);
    }
  }
  return GeneralNetError(message: "Unknown Error", underlying: error);
}
