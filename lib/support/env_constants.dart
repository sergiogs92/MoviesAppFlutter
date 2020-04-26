enum Environment { DEV, PRO }

class EnvConstants {

  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {

    switch (env) {

      case Environment.DEV:

        _config = _Config.devConstants;

        break;

      case Environment.PRO:

        _config = _Config.prodConstants;

        break;
    }
  }

  static get BASE_URL {

    return _config[_Config.BASE_URL];
  }

}
class _Config {

  static final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  static final _baseUrl = "http://api.themoviedb.org/3/movie";

  static const BASE_URL = "baseUrl";

  static Map<String, dynamic> devConstants = {

    BASE_URL: "$_baseUrl/popular?api_key=$_apiKey"
  };

  static Map<String, dynamic> prodConstants = {

    BASE_URL: "$_baseUrl/popular?api_key=$_apiKey"
  };

}