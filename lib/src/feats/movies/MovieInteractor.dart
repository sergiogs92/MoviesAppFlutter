import 'package:movies_app/src/core/CoreEngine.dart';

class MovieInteractor {
  getAllMovies() => CoreEngine.getInstance().movies.getMovies();
}

class MovieException implements Exception {

  MovieError _error;

  MovieException(this._error);

  MovieError get error => _error;

}

enum MovieError { UNKNOWN, BAD_CONNECTION, SERVER_ERROR, NONE }

final movieInteractor = MovieInteractor();
