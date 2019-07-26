import 'package:movies_app/src/core/CoreEngine.dart';

class MovieListInteractor {
  getAllMovies() => CoreEngine.getInstance().movies.getMovies();
}

class MovieListException implements Exception {

  MovieListError _error;

  MovieListException(this._error);

  MovieListError get error => _error;

}

enum MovieListError { UNKNOWN, BAD_CONNECTION, SERVER_ERROR, NONE }
