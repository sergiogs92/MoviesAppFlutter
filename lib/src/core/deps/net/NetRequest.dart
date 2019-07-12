class NetRequest {
  Methods method;
  Map<String, String> headers;
  String url;
  Body body;

  NetRequest(this.method, this.headers, this.url, this.body);
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
