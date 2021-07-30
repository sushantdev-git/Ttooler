import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  CustomPageRouteBuilder({required this.enterPage, required this.exitPage})
      : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondAnimation) => enterPage,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondAnimation,
    Widget child, //this child in enter page that we are passing in to the super constructor
  ) {
    return Stack(children: [
      SlideTransition(
        position: Tween(
          begin: Offset(0, 0),
          end: Offset(-0.3,0)
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: exitPage,
      ),
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
        child: child,
      ),
    ]);
  }
}
