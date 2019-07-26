import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movies_app/src/core/domains/MovieDomain.dart';

import 'MovieListComponent.dart';
import 'MovieListInteractor.dart';
import 'MovieListView.dart';
import 'moviedetail/MovieDetailComponent.dart';
import 'moviedetail/MovieDetailController.dart';

class MovieListController implements MovieListViewListener {
  MovieListInteractor _interactor = MovieListInteractor();
  MovieListView _view = MovieListView();

  set itemListView(MovieListView value) {
    _view = value;
    _loadItems();
  }

  _loadItems() async {
    try {
      DataMovie dataMovie = await _interactor.getAllMovies();
      _view.paintMovies(dataMovie.movies);
    } on MovieListException catch (e) {
      _view.renderError(e.error);
    }
  }

  @override
  onNavigateToDetail(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MovieDetailPage(MovieDetailController(movie: movie))),
    );
  }
}
