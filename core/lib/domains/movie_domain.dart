import 'package:core/core/movies/net_domain.dart';

class MovieList {
  final List<Movie> movies;

  MovieList({this.movies});

  factory MovieList.fromNetMovies(List<NetDataMovie> netMovies) {
    List<Movie> movieList = [];
    for (int i = 0; i < netMovies.length; i++) {
      Movie movie = Movie(
          netMovies[i].id,
          "https://image.tmdb.org/t/p/w185" + netMovies[i].posterPath,
          netMovies[i].originalTitle,
          netMovies[i].overview);
      movieList.add(movie);
    }
    return MovieList(movies: movieList);
  }

}

class Movie {
  final int id;
  final String url;
  final String title;
  final String description;

  Movie(this.id, this.url, this.title, this.description);

}