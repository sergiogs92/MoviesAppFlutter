import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoadingView extends StatelessWidget {
  final Observable<bool> isLoading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Widget child;

  LoadingView(
      {@required this.isLoading,
        @required this.child,
        this.opacity = 0.5,
        this.progressIndicator = const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
        this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isLoading,
      builder: (context, snap) => buildLoading(context, snap),
    );
  }

  Widget buildLoading(BuildContext context, AsyncSnapshot snap) {
    var widgets = <Widget>[];
    widgets.add(child);
    if (snap.hasData && snap.data) {
      final modal = Stack(children: <Widget>[
        Opacity(
          child: ModalBarrier(
            dismissible: false,
            color: color,
          ),
          opacity: opacity,
        ),
        Center(child: progressIndicator),
      ]);
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}
