import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class StringLocalization {
  StringLocalization(this.locale);

  final Locale locale;

  static StringLocalization of(BuildContext context) {
    return Localizations.of<StringLocalization>(context, StringLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Movies',
      'errorBadConnection': 'Internet not connection',
      'errorLoadMovies': 'Error to load movies'
    },
    'es': {
      'title': 'Películas',
      'errorBadConnection': 'No estás conectado a internet',
      'errorLoadMovies': 'Error al cargar las películas'
    }
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get errorBadConnection {
    return _localizedValues[locale.languageCode]['errorBadConnection'];
  }

  String get errorLoadMovies {
    return _localizedValues[locale.languageCode]['errorLoadMovies'];
  }
}

class StringLocalizationDelegate
    extends LocalizationsDelegate<StringLocalization> {
  const StringLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<StringLocalization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<StringLocalization>(StringLocalization(locale));
  }

  @override
  bool shouldReload(StringLocalizationDelegate old) => false;
}
