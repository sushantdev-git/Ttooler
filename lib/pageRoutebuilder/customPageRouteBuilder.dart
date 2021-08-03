import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  CustomPageRouteBuilder({required this.enterPage, required this.exitPage})
      : super(
          transitionDuration: Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondAnimation) => enterPage,
        );

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
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: child,
      );
  }
}
