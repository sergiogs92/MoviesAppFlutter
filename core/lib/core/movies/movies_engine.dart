import 'dart:async';

import 'package:core/core/movies/movies.dart';
import 'package:core/dep/result.dart';
import 'package:core/domains/movie_domain.dart';

import 'movies_service.dart';

class MovieEngine implements Movies {
  MovieService _service;

  MovieEngine(MovieService movieService) {
    _service = movieService;
  }

  @override
  Future<Result<DataMovie, MoviesException>> getMovies() =>
      _service.getMovieList();
}
