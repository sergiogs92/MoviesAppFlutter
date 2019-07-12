import 'package:movies_app/src/core/deps/net/MovieNetClient.dart';

abstract class NetClient {

  Future netRequest(Request request);

}
