import 'dart:convert';

import 'package:movies_app/src/core/deps/net/NetClient.dart';
import 'package:http/http.dart';

class MovieNetClient implements NetClient {
  String _baseUrl;

  MovieNetClient(String baseUrl) {
    this._baseUrl = baseUrl;
  }

  Future netRequest(Request request) async {
    switch (request.method) {
      case Methods.GET:
        final response = await get(_baseUrl + request.url);
        return _checkResponse(response);
        break;
      case Methods.POST:
        final response = await post(_baseUrl + request.url,
            headers: request.body.headers,
            body: json.encode(request.body.body),
            encoding: Encoding.getByName(request.body.encoding));
        return _checkResponse(response);
        break;
    }
  }

  Map<String, dynamic> _checkResponse(Response response) {
    return response.statusCode == 200
        ? json.decode(response.body)
        : throw NetClientException(response.statusCode);
  }
}

class Request {
  Methods method;
  Map<String, String> headers;
  String url;
  Body body;

  Request(this.method, this.headers, this.url, this.body);
}

enum Methods { GET, POST }

class Body {
  Map<String, String> headers;
  Object body;
  String encoding;
}

class NetClientException implements Exception {
  int _statusCode;

  NetClientException(this._statusCode);

  int get statusCode => _statusCode;
}
