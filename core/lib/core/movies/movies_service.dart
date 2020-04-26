import 'dart:async';

import 'package:core/core/movies/movies.dart';
import 'package:core/core/movies/net_domain.dart';
import 'package:core/dep/net/net_client.dart';
import 'package:core/dep/result.dart';
import 'package:core/domains/movie_domain.dart';
import 'package:core/internal/support/net/processors/processor_builder.dart';

class MovieService {
  NetClient _netClient;

  MovieService(NetClient client) {
    _netClient = client;
  }

  Future<Result<List<Movie>, MoviesException>> getMovies() async {
    return await _netClient
        .request(NetRequest(method: NetRequestMethod.get, url: ""))
        .then((response) => response.fold((NetResponse response) {
              return Result.success(_toGetMovies(response));
            }, (NetError error) {
              return Result.failure(_toGetMoviesError(error));
            }));
  }

  List<Movie> _toGetMovies(NetResponse response) {
    final netMovies = response.toResponseFormatted<NetMovieList>(NetMovieList());
    return MovieList.fromNetMovies(netMovies.movies).movies;
  }

  MoviesException _toGetMoviesError(NetError error){
    print(error);
    switch (error.code) {
      case NetErrorCode.connectionError:
        return MoviesException(MoviesError.BAD_CONNECTION);
        break;
      case NetErrorCode.general:
        return MoviesException(MoviesError.SERVER_ERROR);
        break;
      default:
        return MoviesException(MoviesError.UNKNOWN);
    }
  }

}
