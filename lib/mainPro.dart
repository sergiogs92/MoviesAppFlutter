import 'package:flutter/material.dart';
import 'package:movies_app/support/env_constants.dart';
import 'package:movies_app/support/ui/material_app_view.dart';

void main() {
  EnvConstants.setEnvironment(Environment.PRO);
  runApp(MaterialAppView());
}
