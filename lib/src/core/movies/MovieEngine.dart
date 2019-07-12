import 'dart:async';

import 'package:movies_app/src/core/domains/MovieDomain.dart';

import 'MovieService.dart';

class MovieEngine implements Movies {
  MovieService _service;

  MovieEngine(MovieService movieService) {
    _service = movieService;
  }

  @override
  Future<DataMovie> getMovies() => _service.getMovieList();

}

abstract class Movies {
  Future<DataMovie> getMovies();
}
