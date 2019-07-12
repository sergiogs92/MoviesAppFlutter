import 'dart:async';
import 'dart:io';
import 'package:movies_app/src/core/deps/net/NetDartClient.dart';
import 'package:movies_app/src/core/deps/net/NetRequest.dart';
import 'package:movies_app/src/core/domains/MovieDomain.dart';
import 'package:movies_app/src/core/movies/NetDomain.dart';
import 'package:movies_app/src/feats/movies/MovieInteractor.dart';

class MovieService {
  NetDartClient _netClient;

  MovieService(NetDartClient client) {
    _netClient = client;
  }

  Future<DataMovie> getMovieList() async {
    try {
      final response = await _netClient.netRequest(NetRequest(Methods.GET, Map(), "", null));
      return DataMovie.fromNetMovies(NetMovie.fromJson(response).results);
    } on SocketException catch (_) {
      throw _handleException(NetClientException(-1));
    } on NetClientException catch (e) {
      throw _handleException(e);
    }
  }

  MovieException _handleException(NetClientException e) {
    switch (e.statusCode) {
      case -1:
        return MovieException(MovieError.BAD_CONNECTION);
        break;
      case 500:
        return MovieException(MovieError.SERVER_ERROR);
        break;
      default:
        return MovieException(MovieError.UNKNOWN);
    }
  }

}
