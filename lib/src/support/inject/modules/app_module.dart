import "package:core/core_engine.dart";
import 'package:core/support/lazy.dart';
import 'package:movies_app/src/support/EnvConstants.dart';
import 'package:movies_app/src/support/dep/net/net_client.dart';

class AppModule {
  Lazy<CoreEngine> _coreModule;
  Lazy<CoreDeps> _coreDeps;

  AppModule() {
    _coreDeps = Lazy(() => CoreDeps(Configuration(EnvConstants.BASE_URL), AppNetClientBuilder()));
    _coreModule = Lazy(() => CoreEngine(_deps));
  }

  CoreEngine get coreModule => _coreModule();

  CoreDeps get _deps => _coreDeps();
}