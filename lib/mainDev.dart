import 'package:movies_app/src/core/CoreEngine.dart';
import 'package:movies_app/src/support/EnvConstants.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';

void main() {
  EnvConstants.setEnvironment(Environment.DEV);
  CoreEngine.getInstance().initialize();
  runApp(App());
}
