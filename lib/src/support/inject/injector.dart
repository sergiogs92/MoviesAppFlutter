import 'package:movies_app/src/support/inject/modules/app_module.dart';
import 'package:core/core/movies/movies.dart';

class _Injector {
  static AppModule appModule = AppModule();
}

Movies injectMovies() => _Injector.appModule.movies;
