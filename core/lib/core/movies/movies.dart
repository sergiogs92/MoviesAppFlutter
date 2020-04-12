import 'package:core/dep/result.dart';
import 'package:core/domains/movie_domain.dart';

abstract class Movies {
  Future<Result<DataMovie, MoviesException>> getMovies();
}

class MoviesException implements Exception {
  MoviesError _error;

  MoviesException(this._error);

  MoviesError get error => _error;
}

enum MoviesError { UNKNOWN, BAD_CONNECTION, SERVER_ERROR, NONE }
