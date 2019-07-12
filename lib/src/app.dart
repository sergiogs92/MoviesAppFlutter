import 'package:movies_app/src/support/StringLocalization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'feats/movies/MovieListWidget.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => StringLocalization.of(context).title,
      localizationsDelegates: [
        const StringLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MovieListWidget(),
      ),
    );
  }
}