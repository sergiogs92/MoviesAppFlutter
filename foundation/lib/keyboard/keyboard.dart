import 'package:flutter/cupertino.dart';

void hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(new FocusNode());
