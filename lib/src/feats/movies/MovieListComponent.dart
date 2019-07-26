import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/core/domains/MovieDomain.dart';
import 'package:movies_app/src/feats/movies/MovieListInteractor.dart';
import 'package:movies_app/src/support/StringLocalization.dart';

import 'MovieListController.dart';
import 'MovieListView.dart';

class MovieListPage extends StatefulWidget {
  final MovieListController controller;

  MovieListPage(this.controller);

  @override
  State<StatefulWidget> createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> implements MovieListView {
  static const PORTRAIT_NUM_COLUMNS = 2;
  static const LANDSCAPE_NUM_COLUMNS = 3;

  List<Movie> _movies = [];
  String _error = "";

  @override
  void initState() {
    super.initState();
    this.widget.controller.itemListView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildList(_movies),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(StringLocalization.of(context).title),
    );
  }

  Widget buildList(List<Movie> itemList) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    if (itemList.length != 0) {
      return GridView.builder(
          itemCount: itemList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (isPortrait) ? PORTRAIT_NUM_COLUMNS : LANDSCAPE_NUM_COLUMNS),
          itemBuilder: (BuildContext context, int index) {
            return buildItem(itemList[index], index, isPortrait);
          });
    } else if (_error.isNotEmpty) {
      return Align(alignment: Alignment.center, child: Text(_error));
    }
    return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)));
  }

  Widget buildItem(Movie movie, int index, bool isPortrait) {
    return GridTile(
      child: InkResponse(
          enableFeedback: true,
          child: Image.network(
            movie.url,
            fit: BoxFit.fill,
          ),
          onTap: () =>
              this.widget.controller.onNavigateToDetail(context, movie)),
    );
  }

  @override
  paintMovies(List<Movie> movies) {
    setState(() {
      _movies = movies;
    });
  }

  @override
  renderError(MovieListError error) {
    setState(() {
      _error = (error == MovieListError.BAD_CONNECTION)
          ? StringLocalization.of(context).errorBadConnection
          : StringLocalization.of(context).errorLoadMovies;
    });
  }
}

class MovieListViewListener {
  onNavigateToDetail(BuildContext context, Movie movie) {}
}
