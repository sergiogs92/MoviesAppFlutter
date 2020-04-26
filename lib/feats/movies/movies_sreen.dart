import 'package:core/domains/movie_domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:foundation/ui/base_screen_state.dart";
import "package:foundation/ui/base_state.dart";
import 'package:movies_app/feats/movies/movies_bloc.dart';
import 'package:movies_app/support/string_localization.dart';
import 'package:movies_app/support/ui/custom/loading_view.dart';

class MoviesScreen extends BaseState {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends BaseScreenState<MoviesBloc> {
  static const PORTRAIT_NUM_COLUMNS = 2;
  static const LANDSCAPE_NUM_COLUMNS = 3;

  @override
  MoviesBloc provideBloc() => MoviesBloc();

  @override
  void initState() {
    super.initState();
    bloc.loadMovies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildLoading(SingleChildScrollView(child: buildDataContainer())));
  }

  Widget buildLoading(Widget child) {
    return LoadingView(child: child, isLoading: bloc.loading);
  }

  Widget buildDataContainer() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(appBar: buildAppBar(), body: buildMovies()));
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(StringLocalization.of(context).title),
    );
  }

  Widget buildMovies() {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    return StreamBuilder<List<Movie>>(
        stream: bloc.movies,
        builder: (context, snap) {
          if (snap.hasData) {
            return GridView.builder(
                itemCount: snap.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (isPortrait)
                        ? PORTRAIT_NUM_COLUMNS
                        : LANDSCAPE_NUM_COLUMNS),
                itemBuilder: (BuildContext context, int index) {
                  return buildMovieItem(snap.data[index], index, isPortrait);
                });
          } else if (snap.hasError) {
            return Align(alignment: Alignment.center, child: Text(snap.error));
          } else
            return Container();
        });
  }

  Widget buildMovieItem(Movie movie, int index, bool isPortrait) {
    return GridTile(
        child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              movie.url,
              fit: BoxFit.fill,
            ),
            onTap: () => {}));
  }
}
