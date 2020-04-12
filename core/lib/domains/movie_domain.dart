import 'package:core/core/movies/net_domain.dart';

class DataMovie {
  List<Movie> _movies = [];

  DataMovie.fromNetMovies(List<NetDataMovie> netMovies) {
    List<Movie> temp = [];
    for (int i = 0; i < netMovies.length; i++) {
      Movie result = Movie(
          netMovies[i].identifier,
          "https://image.tmdb.org/t/p/w185" + netMovies[i].posterPath,
          netMovies[i].originalTitle,
          netMovies[i].description);
      temp.add(result);
    }
    _movies = temp;
  }

  List<Movie> get movies => _movies;
}

class Movie {
  int id;
  String url;
  String title;
  String description;

  Movie(this.id, this.url, this.title, this.description);


  Movie.movieInfo({this.id, this.url, this.title, this.description});

}