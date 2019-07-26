import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/core/domains/MovieDomain.dart';

import 'MovieDetailController.dart';
import 'MovieDetailView.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieDetailController controller;

  MovieDetailPage(this.controller);

  @override
  State<StatefulWidget> createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage>
    implements MovieDetailView {
  Movie _movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new NestedScrollView(
      headerSliverBuilder: buildHeadersSlivers(),
      body: buildDescription(),
    ));
  }

  NestedScrollViewHeaderSliversBuilder buildHeadersSlivers() {
    return (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 250.0,
          floating: true,
          pinned: true,
          elevation: 0.0,
          flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
            _movie.url,
            fit: BoxFit.fill,
          )),
        ),
      ];
    };
  }

  Widget buildDescription() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Container(margin: EdgeInsets.only(top: 5.0)),
            Text(
              _movie.title,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
            Text(_movie.description)
          ]),
        )
      ],
    );
  }

  @override
  paintMovieDetail(Movie movie) {
    setState(() {
      _movie = movie;
    });
  }
}
