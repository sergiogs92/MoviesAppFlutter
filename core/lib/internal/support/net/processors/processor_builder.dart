import 'dart:convert';

import 'package:core/dep/net/net_client.dart';

extension NetResponseFormatted on NetResponse {
  T toResponseFormatted<T extends Deserializer>(T value) {
    try {
      final map = jsonDecode(body.map(_toGetBytes).value);
      return value.fromJson(map);
    } catch (error) {
      throw error;
    }
  }

  String _toGetBytes(List<int> bytes) => utf8.decode(bytes) ?? '$bytes';
}

abstract class Deserializer<T> {
  T fromJson(Map<String, dynamic> json);
}
