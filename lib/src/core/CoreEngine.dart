import 'package:movies_app/src/support/EnvConstants.dart';

import 'deps/net/NetDartClient.dart';
import 'movies/MovieEngine.dart';
import 'movies/MovieService.dart';

class CoreEngine {
  static final CoreEngine _singleton = new CoreEngine._internal();

  CoreEngine._internal();

  static CoreEngine getInstance() => _singleton;

  NetDartClient _client;
  MovieEngine _movies;


  void initialize() {
    _client = NetDartClient(EnvConstants.BASE_URL);
    _movies = MovieEngine(MovieService(_client));
  }

  get netClient => _client;

  get movies => _movies;
}
