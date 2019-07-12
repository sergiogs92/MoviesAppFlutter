import 'package:movies_app/src/core/domains/MovieDomain.dart';
import 'package:flutter/material.dart';

class MovieDetailWidget extends StatelessWidget {
  final Movie movie;

  MovieDetailWidget({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 250.0,
            floating: true,
            pinned: true,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              movie.url,
              fit: BoxFit.fill,
            )),
          ),
        ];
      },
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              Container(margin: EdgeInsets.only(top: 5.0)),
              Text(
                movie.title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
              Text(movie.description)
            ]),
          )
        ],
      ),
    ));
  }
}
