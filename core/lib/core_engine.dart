import 'dart:convert';

import 'package:core/dep/net/net.dart';
import 'package:core/internal/support/net/clients/basic_net_client.dart';
import 'package:core/support/lazy.dart';

class CoreEngine {
  final CoreDeps _coreDeps;

  CoreEngine(this._coreDeps);

  Lazy<BasicNetClient> _buildBasicNetClient() => Lazy(() => BasicNetClient(
      _coreDeps.configuration.baseUrl,
      _coreDeps.netClientBuilder.buildClient()));

  BasicNetClient get _basicNetClient => _buildBasicNetClient().call();

}

class CoreDeps {
  final Configuration configuration;
  final NetClientBuilder netClientBuilder;

  CoreDeps(this.configuration, this.netClientBuilder);
}

class Configuration {
  final String baseUrl;

  Configuration(this.baseUrl);
}
