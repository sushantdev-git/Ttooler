import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget child;

  CustomPageRouteBuilder({required this.child})
      : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: child,
    );
  }
}
