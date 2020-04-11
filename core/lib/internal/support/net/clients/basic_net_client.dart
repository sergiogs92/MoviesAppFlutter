import 'package:core/dep/net/net_client.dart';
import 'package:core/dep/result.dart';

class BasicNetClient implements NetClient {
  String _baseUrl;
  final NetClient _netClient;

  BasicNetClient(this._baseUrl, this._netClient);

  @override
  Future<Result<NetResponse, NetError>> request(NetRequest request) {
    return _netClient.request(request.updatingUrl(_baseUrl + request.url));
  }
}

extension _UpdatingUrl on NetRequest {
  NetRequest updatingUrl(String url) {
    return NetRequest(method: method, url: url, body: body, headers: headers);
  }
}
