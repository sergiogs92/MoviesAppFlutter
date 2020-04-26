import 'package:core/core/movies/movies.dart';
import 'package:core/domains/movie_domain.dart';
import 'package:flutter/cupertino.dart';
import "package:foundation/ui/base_bloc.dart";
import 'package:movies_app/support/inject/injector.dart';
import 'package:movies_app/support/string_localization.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BaseBloc {
  final BehaviorSubject _moviesController = BehaviorSubject<List<Movie>>();
  final PublishSubject _loadingController = PublishSubject<bool>();

  Function(List<Movie>) get updateMovies => _moviesController.sink.add;
  Function(bool) get _updateLoading => _loadingController.sink.add;

  Observable<List<Movie>> get movies => _moviesController.stream;
  Observable<bool> get loading => _loadingController.stream;

  void loadMovies(BuildContext context) async {
    _updateLoading(true);
    await injectMovies()
        .getMovies()
        .then((response) => response.fold((List<Movie> movies) {
              _updateLoading(false);
              updateMovies(movies);
            }, (MoviesException moviesError) {
              _updateLoading(false);
              _moviesController.sink.addError(_sendError(context, moviesError.error));
            }));
  }

  String _sendError(BuildContext context, MoviesError error) {
    return (error == MoviesError.BAD_CONNECTION)
        ? StringLocalization.of(context).errorBadConnection
        : StringLocalization.of(context).errorLoadMovies;
  }

  @override
  void dispose() {
    _moviesController.close();
    _loadingController.close();
  }
}
