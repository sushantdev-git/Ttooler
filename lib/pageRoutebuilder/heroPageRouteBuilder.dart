
import 'dart:ui';

import 'package:flutter/material.dart';

/// {@template hero_dialog_route}
/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}
class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings ? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black12;

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondAnimation,
      Widget child, //this child in enter page that we are passing in to the super constructor
      ) {
    return
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: child,
      );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}