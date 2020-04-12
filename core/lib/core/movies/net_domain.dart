import 'package:core/internal/support/net/processors/processor_builder.dart';

class NetMovie implements Deserializer<NetMovie> {
  List<NetDataMovie> movies;

  NetMovie({this.movies});

  @override
  NetMovie fromJson(Map<String, dynamic> json) {
    for (int i = 0; i < json['results'].length; i++) {
      NetDataMovie result = NetDataMovie(json['results'][i]);
      movies.add(result);
    }
    return this;
  }
}

class NetDataMovie {
  int _id;
  String _posterPath;
  String _originalTitle;
  String _overview;

  NetDataMovie(result) {
    _id = result['id'];
    _posterPath = result['poster_path'];
    _originalTitle = result['original_title'];
    _overview = result['overview'];
  }

  int get identifier => _id;

  String get originalTitle => _originalTitle;

  String get posterPath => _posterPath;

  String get description => _overview;
}
