import 'package:core/internal/support/net/processors/processor_builder.dart';

class NetMovieList implements Deserializer<NetMovieList> {
  final List<NetDataMovie> movies;

  NetMovieList({this.movies});

  @override
  NetMovieList fromJson(Map<String, dynamic> json) {
    final jsonList = json['results'] as List;
    final netMovies = jsonList
        .map((jsonElement) => NetDataMovie().fromJson(jsonElement))
        .toList();
    return NetMovieList(movies: netMovies);
  }
}

class NetDataMovie implements Deserializer<NetDataMovie> {
  final int id;
  final String posterPath;
  final String originalTitle;
  final String overview;

  NetDataMovie({this.id, this.posterPath, this.originalTitle, this.overview});

  @override
  NetDataMovie fromJson(Map<String, dynamic> json) {
    return NetDataMovie(
        id: json['id'], 
        posterPath: json['poster_path'], 
        originalTitle: json['original_title'], 
        overview: json['overview']);
  }
}
