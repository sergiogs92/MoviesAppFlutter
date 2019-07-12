
class NetMovie {
  List<NetDataMovie> _movies = [];

  NetMovie.fromJson(Map<String, dynamic> jsonMap) {
    List<NetDataMovie> temp = [];
    for (int i = 0; i < jsonMap['results'].length; i++) {
      NetDataMovie result = NetDataMovie(jsonMap['results'][i]);
      temp.add(result);
    }
    _movies = temp;
  }

  List<NetDataMovie> get results => _movies;
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
