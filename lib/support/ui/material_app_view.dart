import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/feats/movies/movies_sreen.dart';
import 'package:movies_app/support/string_localization.dart';

class MaterialAppView extends StatelessWidget {
  @override
  Widget build(BuildContext contextP) {
    return MaterialApp(
        onGenerateTitle: (BuildContext context) =>
        StringLocalization.of(context).title,
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
        debugShowCheckedModeBanner: false,
        home: MoviesScreen());
  }
}
