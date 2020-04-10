import 'package:flutter/cupertino.dart';

import 'base_bloc.dart';
import 'base_state.dart';

abstract class BaseScreenState<T extends BaseBloc> extends State<BaseState> {
  T _bloc;

  T provideBloc();

  T get bloc => _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = provideBloc();
    if (_bloc == null) throw "Must provide a valid bloc";
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
