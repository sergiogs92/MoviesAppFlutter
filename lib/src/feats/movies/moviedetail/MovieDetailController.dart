import 'package:movies_app/src/core/domains/MovieDomain.dart';

import 'MovieDetailView.dart';

class MovieDetailController {
  MovieDetailView _view = MovieDetailView();

  final Movie movie;

  MovieDetailController({this.movie});

  set movieDetailView(MovieDetailView view) {
    _view = view;
    _loadDetail();
  }

  _loadDetail() {
    _view.paintMovieDetail(movie);
  }
}
