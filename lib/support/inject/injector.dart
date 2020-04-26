import 'package:core/core/movies/movies.dart';
import 'package:movies_app/support/inject/modules/app_module.dart';

class _Injector {
  static AppModule appModule = AppModule();
}

Movies injectMovies() => _Injector.appModule.movies;
