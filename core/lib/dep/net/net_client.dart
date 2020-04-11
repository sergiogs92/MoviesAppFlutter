import 'dart:convert';

import 'package:core/dep/optional.dart';
import 'package:core/dep/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

abstract class NetClient {
  Future<Result<NetResponse, NetError>> request(NetRequest request);
}

class NetRequest {
  final NetRequestMethod method;
  final String url;
  final Optional<NetRequestBody> body;
  final Map<String, String> headers;

  NetRequest(
      {@required this.method,
      @required this.url,
      Optional<NetRequestBody> body,
      this.headers = const {}})
      : body = body ?? Optional(null);

  NetRequest.get({@required String url, Map<String, String> headers = const {}})
      : this(method: NetRequestMethod.get, url: url, headers: headers);

  NetRequest.post(
      {@required String url,
      @required NetRequestBody body,
      Map<String, String> headers = const {}})
      : this(
            method: NetRequestMethod.post,
            url: url,
            body: Optional(body),
            headers: headers);

  NetRequest.put(
      {@required String url,
      @required NetRequestBody body,
      Map<String, String> headers = const {}})
      : this(
            method: NetRequestMethod.put,
            url: url,
            body: Optional(body),
            headers: headers);

  NetRequest.patch(
      {@required String url,
      @required NetRequestBody body,
      Map<String, String> headers = const {}})
      : this(
            method: NetRequestMethod.patch,
            url: url,
            body: Optional(body),
            headers: headers);

  NetRequest.delete(
      {@required String url, Map<String, String> headers = const {}})
      : this(method: NetRequestMethod.delete, url: url, headers: headers);

  @override
  String toString() {
    return 'NetRequest{method: $method, url: $url, body: $body, headers: $headers}';
  }
}

enum NetRequestMethod { get, head, post, put, patch, delete }

class NetRequestBody {
  final String contentType;
  final String content;

  NetRequestBody(this.contentType, this.content);

  @override
  String toString() {
    return 'NetRequestBody{contentType: $contentType, content: $content}';
  }
}

class NetResponse {
  final int statusCode;
  final Map<String, String> headers;
  final Optional<List<int>> body;

  NetResponse(
      {@required this.statusCode, @required this.headers, List<int> body})
      : body = Optional(body);

  @override
  String toString() {
    return 'NetResponse{statusCode: $statusCode, headers: $headers, body: ${body.map(_printableBytes)}}';
  }
}

const netContentTypeJson = "application/json";
const netContentTypeFormUrlEncoded = "application/x-www-form-urlencoded";

const netHeaderAuthorization = "Authorization";
const netHeaderContentType = "Content-Type";

@sealed
abstract class NetError {
  final NetErrorCode code;

  NetError(this.code);
}

enum NetErrorCode { errorResponse, connectionError, general }

class ErrorResponseNetError implements NetError {
  @override
  NetErrorCode get code => NetErrorCode.errorResponse;
  final NetResponse response;
  final Object underlying;

  ErrorResponseNetError({@required this.response, @required this.underlying});

  @override
  String toString() {
    return 'ErrorResponseNetError{response: $response, underlying: $underlying}';
  }
}

class ConnectionErrorNetError implements NetError {
  @override
  NetErrorCode get code => NetErrorCode.connectionError;
  final Object underlying;

  ConnectionErrorNetError({@required this.underlying});

  @override
  String toString() {
    return 'ConnectionErrorNetError{underlying: $underlying}';
  }
}

class GeneralNetError implements NetError {
  @override
  NetErrorCode get code => NetErrorCode.general;
  final String message;
  final Optional<Object> underlying;

  GeneralNetError({@required this.message, Object underlying})
      : underlying = Optional(underlying);

  @override
  String toString() {
    return 'GeneralNetError{message: $message, underlying: $underlying}';
  }
}

String _printableBytes(List<int> bytes) => utf8.decode(bytes) ?? '$bytes';
