import 'package:movies_app/src/core/deps/net/NetRequest.dart';

abstract class NetClient {
  Future netRequest(NetRequest request);
}
