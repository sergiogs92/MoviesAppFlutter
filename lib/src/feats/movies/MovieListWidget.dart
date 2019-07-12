import 'package:movies_app/src/core/domains/MovieDomain.dart';
import 'package:movies_app/src/support/StringLocalization.dart';
import 'package:flutter/material.dart';

import 'MovieInteractor.dart';

class MovieListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringLocalization.of(context).title),
      ),
      body: FutureBuilder<DataMovie>(
        future: movieInteractor.getAllMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            MovieException exception = snapshot.error;
            return Align(
                alignment: Alignment.center,
                child: Text(exception.error == MovieError.BAD_CONNECTION
                    ? StringLocalization.of(context).errorBadConnection
                    : StringLocalization.of(context).errorLoadMovies));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<DataMovie> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.movies.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                snapshot.data.movies[index].url,
                fit: BoxFit.fill,
              )
            ),
          );
        });
  }

}
