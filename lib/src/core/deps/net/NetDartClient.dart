import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies_app/src/core/deps/net/NetClient.dart';
import 'package:movies_app/src/core/deps/net/NetRequest.dart';

class NetDartClient implements NetClient {
  String _baseUrl;

  NetDartClient(String baseUrl) {
    this._baseUrl = baseUrl;
  }

  Future netRequest(NetRequest request) async {
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
